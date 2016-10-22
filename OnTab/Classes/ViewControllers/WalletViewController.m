//
//  WalletViewController.m
//  OnTab
//
//  Created by ZhenLiu on 11/19/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import "WalletViewController.h"
#import "LeveyTabBarController.h"
#import "AKSSegmentedSliderControl.h"
#import "SuccessViewController.h"

@interface WalletViewController () <LeveyTabBarControllerDelegate, UITextFieldDelegate, ServerCallDelegate, AKSSegmentedSliderControlDelegate> {

    IBOutlet UIView*    vCnt;
    IBOutlet UIScrollView*  scrlView;
    IBOutlet UIView*    vVisa;
    IBOutlet UIView*    vMaster;
    IBOutlet UIView*    vAmeracan;
    
    IBOutlet UILabel*   lblAmount;
    IBOutlet UITextField*   tfTips;

    double amount;
    BOOL isMakePaymentAPI;
    int whoShowed;
    
    NSArray*    mArrCard;
    
    int mSelectedCardId;
}

@end

@implementation WalletViewController

@synthesize nInvoiceId, dictDetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"PAY YOUR BILL";
        [self setLeftBarButtonImage:@"btn_back"];
        [self setRightBarButtonImage:@"btn_ontab"];
    }
    return self;
}

-(void)prepareSlider{
    
#define WIDTH  200
#define HEIGHT 34
#define X_POS  9
#define Y_POS  80
#define RADIUS_POINT  2
#define SPACE_BETWEEN_POINTS  26
#define SLIDER_LINE_WIDTH     6
#define IPHONE_4_SUPPORT      88
    
	CGRect sliderConrolFrame = CGRectNull;
    
	sliderConrolFrame = CGRectMake(X_POS,Y_POS+6.5,WIDTH,HEIGHT);
    
    AKSSegmentedSliderControl* sliderControl = [[AKSSegmentedSliderControl alloc] initWithFrame:sliderConrolFrame];
    [sliderControl setDelegate:self];
	[sliderControl moveToIndex:0];
	[sliderControl setSpaceBetweenPoints:SPACE_BETWEEN_POINTS];
	[sliderControl setRadiusPoint:RADIUS_POINT];
	[sliderControl setHeightLine:SLIDER_LINE_WIDTH];
    [scrlView addSubview:sliderControl];
    
}

#pragma mark -
#pragma mark AKSSegmentedSliderControlDelegate

- (void)timeSlider:(AKSSegmentedSliderControl *)timeSlider didSelectPointAtIndex:(int)index {
    
    for (int i=0; i<5; i++) {
        UILabel*    lbl = (UILabel*)[self.view viewWithTag:i+10];
        if (index == i)
            [lbl setTextColor:[tfTips textColor]];
        else
            [lbl setTextColor:[UIColor colorWithRed:123.0f/255.0f green:120.0f/255.0f blue:111.0f/255.0f alpha:1.0]];
    }
    NSArray*    arr = [NSArray arrayWithObjects:@"0", @"5", @"10", @"15", @"20", nil];
    int percent = [[arr objectAtIndex:index] intValue];
    tfTips.text = [NSString stringWithFormat:@"%.1f", amount / 100 * percent];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    whoShowed = 0;
    scrlView.contentSize = CGSizeMake(320, vCnt.frame.size.height+100);
    [scrlView addSubview:vCnt];
        NSLog(@"%@", NSStringFromCGRect(scrlView.frame));
    
    [self prepareSlider];
    isMakePaymentAPI = NO;
        
    amount = [[self.dictDetail objectForKey:@"amount"] doubleValue];
    amount = amount / 100;
    lblAmount.text = [NSString stringWithFormat:@"$%.2f %@", amount, [self.dictDetail objectForKey:@"currency"]];
    
    [SHAREDMANAGER serverCall].delegate = self;
    [[SHAREDMANAGER serverCall] requestServer:[NSString stringWithFormat:@"https://dashboard.ontab.com/api/cards?access_token=%@", [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"]]];
}

- (void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) hideCardView {

    if (whoShowed == 0)
        return;
    [UIView animateWithDuration:0.3 animations:^{
    
        UIView* vCard = [scrlView viewWithTag:whoShowed];
        CGRect frame = vCard.frame;
        frame.origin.y += 50;
        vCard.frame = frame;
    }];
}

- (void) openCardView {
    
    if (whoShowed == 0)
        return;
    [UIView animateWithDuration:0.3 animations:^{
        
        UIView* vCard = [scrlView viewWithTag:whoShowed];
        CGRect frame = vCard.frame;
        frame.origin.y -= 50;
        vCard.frame = frame;
    }];
}

#pragma mark -
#pragma mark UIButtonActionDelegate

- (IBAction) onClickCard:(id)sender {

    int index = [sender tag] - 1000 +1;
    if (whoShowed == index) {
        [self hideCardView];
        whoShowed = 0;
    }
    else {
        [self hideCardView];
        whoShowed = index;
        [self openCardView];
        
        NSDictionary*   dict = [mArrCard objectAtIndex:index-1];
        mSelectedCardId = [[dict objectForKey:@"id"] intValue];
    }
}

- (IBAction) onClickPaynow:(id)sender {

    [SHAREDMANAGER serverCall].delegate = self;
    isMakePaymentAPI = YES;
    if (mSelectedCardId == 0)
        mSelectedCardId = 4;
    NSString* tip = [NSString stringWithFormat:@"%d", [tfTips.text intValue]];
    NSString*   strPass = [[SHAREDMANAGER dictCards] objectForKey:[NSNumber numberWithInt:mSelectedCardId]];
    NSLog(@"%@", strPass);
    if (strPass == nil) {
        [Utilities showMsg:@"Please enter password first on Wallet page"];
        return;
    } else {
        NSDictionary* dictParam = [NSDictionary dictionaryWithObjectsAndKeys: [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"], @"access_token", tip, @"charge[tips]", [NSString stringWithFormat:@"%d", self.nInvoiceId], @"charge[invoice_id]", [NSString stringWithFormat:@"%d", mSelectedCardId], @"charge[card_id]", @"CDuvTjx8", @"card_password", nil];
        
        NSLog(@"%@", dictParam);
        
        [[SHAREDMANAGER serverCall] requestServerOnPost:@"https://dashboard.ontab.com/api/charges?" data:dictParam];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark-   LevyTabBarControllerDelegate

- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    NSLog(@"TabWallet Selected");
}

#pragma mark - ServerCallDelegate

- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    if (dictData != nil) {
        if (isMakePaymentAPI) {
            NSString*   strStatus = [dictData objectForKey:@"status"];
            if (strStatus != nil && ![strStatus isKindOfClass:[NSNull class]]) {
                if ([strStatus isEqualToString:@"paid"]) {
                    SuccessViewController*  vcSuccess = [[SuccessViewController alloc] initWithNibName:@"SuccessViewController" bundle:nil];
                    vcSuccess.isSuccess = YES;
                    [self.navigationController pushViewController:vcSuccess animated:YES];
                }
            }else {
                SuccessViewController*  vcSuccess = [[SuccessViewController alloc] initWithNibName:@"SuccessViewController" bundle:nil];
                vcSuccess.isSuccess = NO;
                [self.navigationController pushViewController:vcSuccess animated:YES];
            }
        } else {
            mArrCard = [[NSArray alloc] initWithArray:(NSArray*)dictData];
            for (int i=0; i<mArrCard.count; i++) {
                NSDictionary*   dict = [mArrCard objectAtIndex:i];
                UIView* vCard = (UIView*) [vCnt viewWithTag:i+1];
                UIButton*   btn = (UIButton*) [vCard viewWithTag:1000+i];
                
                [btn addTarget:self action:@selector(onClickCard:) forControlEvents:UIControlEventTouchUpInside];
                
                if ([[dict objectForKey:@"card_type"] isEqualToString:@"mastercard"]) {
                    
                    [btn setImage:[UIImage imageNamed:@"wallet_card_master"] forState:UIControlStateNormal];
                }
            }
            for (int i=mArrCard.count; i<6; i++) {
                UIView* vCard = (UIView*) [vCnt viewWithTag:i+1];
                vCard.hidden = YES;
            }
        }
    } else {
        NSLog(@"JSon Parse Error!");
        [Utilities showMsg:[dictData objectForKey:@"errormsg"]];
    }
}

@end
