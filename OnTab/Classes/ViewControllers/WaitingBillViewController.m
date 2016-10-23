//
//  WaitingBillViewController.m
//  OnTab
//
//  Created by Yulian on 11/20/13.
//  Copyright (c) 2013 Yulian. All rights reserved.
//

#import "WaitingBillViewController.h"
#import "SVProgressHUD.h"
#import "WalletViewController.h"

@interface WaitingBillViewController () <ServerCallDelegate> {

    IBOutlet UIView*    vAlert;
    IBOutlet UILabel*   lblTabId;
    BOOL isCancelled;
    BOOL isGetInvoiceDetailAPI;
    
    NSTimer* myTimer;
}

@end

@implementation WaitingBillViewController

@synthesize ontabId, displayInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"WAITING FOR BILL";
        [self setLeftBarButtonImage:@"btn_back"];
        [self setRightBarButtonImage:@"btn_ontab"];
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

}

- (void) callAPIonThread {

    if (!isCancelled)
        [NSThread detachNewThreadSelector:@selector(callApi) toTarget:self withObject:nil];
}

- (void) callApi {

    [SHAREDMANAGER serverCall].delegate = self;
    NSString* strUrl = [NSString stringWithFormat:@"https://dashboard.ontab.com/api/tabs/%d?access_token=%@", self.ontabId, [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"]];
    [[SHAREDMANAGER serverCall] requestServer:strUrl];
//    [SVProgressHUD dismiss];

}

- (void)loadView {

    [super loadView];
 
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isCancelled = NO;
    isGetInvoiceDetailAPI = NO;

    //////////////////////////////////////////////////////
//    self.ontabId = 128; // for test
    //////////////////////////////////////////////////////
    
    lblTabId.text = self.displayInfo;
    
    [NSThread detachNewThreadSelector:@selector(callApi) toTarget:self withObject:nil];
    NSLog(@"%d", self.ontabId);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UIButtonActionDelegate Methods

- (IBAction) onClickCancelPayment:(id)sender {

    vAlert.hidden = YES;
    isCancelled = YES;
    [myTimer invalidate];
    myTimer = nil;
}

#pragma mark -
#pragma mark OActionDelegate Methods
- (void)pressedButton:(id)sender
{
    int tag = (int) [sender tag];
    switch (tag) {
        case kLeftBarButtonItem: {
            [myTimer invalidate];
            myTimer = nil;
            [self.navigationController popViewControllerAnimated:YES];
        }   break;
        case kRightBarButtonItem:
            [APPDELEGATE didLogOut];
            break;
    }
}

#pragma mark - ServerCallDelegate

/*
 {
 "access_token" = d9e33a5e199069412b257d466bf02d36cb429795371f0e4c87cbb3704f681efe;
 "expires_in" = 7200;
 "token_type" = bearer;
 }
 */

- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    if (dictData != nil) {
        if ( ([dictData objectForKey:@"latest_invoice_id"] == nil || [[dictData objectForKey:@"latest_invoice_id"] isKindOfClass:[NSNull class]] ) && !isGetInvoiceDetailAPI) {
            if (!isCancelled)
                myTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(callAPIonThread) userInfo:nil repeats:NO];
        } else {
            if (isGetInvoiceDetailAPI) {
                WalletViewController*   vcWallet = [[WalletViewController alloc] initWithNibName:@"WalletViewController" bundle:nil];
                vcWallet.nInvoiceId = [[dictData objectForKey:@"id"] intValue];
                vcWallet.dictDetail = [NSDictionary dictionaryWithDictionary:dictData];
                [self.navigationController pushViewController:vcWallet animated:YES];
            } else {
                vAlert.hidden = YES;
                NSMutableDictionary*    dict = [NSMutableDictionary dictionaryWithDictionary:[SHAREDMANAGER userSetting]];
                [dict setObject:[dictData objectForKey:@"latest_invoice_id"] forKey:@"latest_invoice_id"];
                [dict setObject:[dictData objectForKey:@"id"] forKey:@"tab_id"];            
                [SHAREDMANAGER setUserSetting:dict];
                [SHAREDMANAGER saveUserSetting];
                
                isGetInvoiceDetailAPI = YES;
                
                [SHAREDMANAGER serverCall].delegate = self;
                NSString*   strUrl = [NSString stringWithFormat:@"https://dashboard.ontab.com/api/invoices/%d?access_token=%@",[[dictData objectForKey:@"latest_invoice_id"] intValue], [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"]];
                [[SHAREDMANAGER serverCall] requestServer:strUrl];
            }
            
        }
    } else {
        NSLog(@"JSon Parse Error!");
        [Utilities showMsg:[dictData objectForKey:@"errormsg"]];
    }
}


@end
