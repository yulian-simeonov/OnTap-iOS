//
//  PlaceViewController.m
//  OnTab
//
//  Created by ZhenLiu on 11/19/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import "PlaceViewController.h"
#import "WaitingBillViewController.h"
#import "WalletViewController.h"

@interface PlaceViewController () <ServerCallDelegate> {

    IBOutlet UIScrollView*  scrlView;
    IBOutlet UIView*        vPlace;
    NSArray*     mArrPos;
    BOOL isGetPosApi;
}

@end

@implementation PlaceViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scrlView.contentSize = CGSizeMake(320, 1000);
    [scrlView addSubview:vPlace];
    
    NSLog(@"%@", NSStringFromCGRect(scrlView.frame));
    
    [SHAREDMANAGER serverCall].delegate = self;
    isGetPosApi = YES;
    [[SHAREDMANAGER serverCall] requestServer:@"https://dashboard.ontab.com/api/point_of_sales"];
}

- (void) viewDidAppear:(BOOL)animated {


    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UIButtonActionDelegate

- (IBAction) onClickPlaces:(id)sender {

    switch ([sender tag]) {
        case 0:
            
            break;
            
        default:
            break;
    }
    
//    if ([[SHAREDMANAGER userSetting] objectForKey:@"latest_invoice_id"] != nil && [[[SHAREDMANAGER userSetting] objectForKey:@"latest_invoice_id"] intValue] != -1) {
//        WalletViewController*   vcWallet = [[WalletViewController alloc] initWithNibName:@"WalletViewController" bundle:nil];
//        vcWallet.nInvoiceId = [[[SHAREDMANAGER userSetting] objectForKey:@"latest_invoice_id"] intValue];
//        [self.navigationController pushViewController:vcWallet animated:YES];
//    } else {
        NSString*   type = [[SHAREDMANAGER userSetting] objectForKey:@"OpenTab"];
        if (type == nil || [type isEqualToString:@""])
            type = @"checkin";
        
        [SHAREDMANAGER serverCall].delegate = self;
        isGetPosApi = NO;
        NSLog(@"%@", [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"]);
        NSString* posId = [NSString stringWithFormat:@"%d", [[[mArrPos objectAtIndex:0] objectForKey:@"id"] intValue]];
        NSDictionary* dictParam = [NSDictionary dictionaryWithObjectsAndKeys:[[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"], @"access_token", posId, @"tab[point_of_sale_id]", type, @"tab[tab_type]", nil];
        NSLog(@"%@", dictParam);
        [[SHAREDMANAGER serverCall] requestServerOnPost:@"https://dashboard.ontab.com/api/tabs?" data:dictParam];
//    }
}

#pragma mark-   LevyTabBarControllerDelegate

- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    NSLog(@"TabPlace Selected");
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
        if (isGetPosApi) {
            mArrPos = [NSArray arrayWithArray:(NSArray*) dictData];
        } else {
            WaitingBillViewController*  vcWaiting = [[WaitingBillViewController alloc] initWithNibName:@"WaitingBillViewController" bundle:nil];
            vcWaiting.ontabId = [[dictData objectForKey:@"id"] integerValue];
            vcWaiting.displayInfo = [dictData objectForKey:@"display_info"];
            [self.navigationController pushViewController:vcWaiting animated:YES];
        }
    } else {
        NSLog(@"JSon Parse Error!");
        [Utilities showMsg:[dictData objectForKey:@"errormsg"]];
    }
}

#pragma mark -
#pragma mark pressButton

- (IBAction)pressedButton:(id)sender
{
    NSInteger tag = ((UIView *) sender).tag;
    
    switch (tag) {
        case kLeftBarButtonItem: {
            
        }   break;
        case kRightBarButtonItem:
            [APPDELEGATE didLogOut];
            break;
    }
}

@end
