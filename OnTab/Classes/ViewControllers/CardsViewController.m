//
//  CardsViewController.m
//  OnTab
//
//  Created by ZhenLiu on 11/21/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import "CardsViewController.h"

@interface CardsViewController () <ServerCallDelegate, UITextFieldDelegate> {

    IBOutlet UIView*    vCnt;
    IBOutlet UIScrollView*  scrlView;
    IBOutlet UIView*    vVisa;
    IBOutlet UIView*    vMaster;
    IBOutlet UIView*    vAmeracan;
    NSArray*    mArrCards;
    int whoShowed;    
}

@end

@implementation CardsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"WALLET";
        [self setRightBarButtonImage:@"btn_ontab"];
    }
    return self;
}

- (void) viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    whoShowed = 0;
    scrlView.contentSize = CGSizeMake(320, vCnt.frame.size.height+100);
    [scrlView addSubview:vCnt];
    
    
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
#pragma mark UITextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    UIView* vCard = [scrlView viewWithTag:whoShowed];
    for (UITextField* tfFld in vCard.subviews) {
        if ([tfFld isKindOfClass:[UITextField class]])
        {
            NSMutableDictionary*    dict = [NSMutableDictionary dictionaryWithDictionary:[[SharedManager sharedManager] dictCards]];
            int id = [[[mArrCards objectAtIndex:whoShowed-1] objectForKey:@"id"] intValue];
            [dict setObject:tfFld.text forKey:[NSNumber numberWithInt:id]];
            
            [SHAREDMANAGER setDictCards:dict];
        }
    }
    return YES;
}

#pragma mark -
#pragma mark UIButtonActionDelegate

- (IBAction) onClickVisa:(id)sender {
    
    if (whoShowed == 1) {
        [self hideCardView];
        whoShowed = 0;
    }
    else {
        [self hideCardView];
        whoShowed = 1;
        [self openCardView];
    }
}

- (IBAction) onClickMaster:(id)sender {
    
    if (whoShowed == 2) {
        [self hideCardView];
        whoShowed = 0;
    }
    else {
        [self hideCardView];
        whoShowed = 2;
        [self openCardView];
    }
}

- (IBAction) onClickAmerican:(id)sender {
    
    if (whoShowed == 3) {
        [self hideCardView];
        whoShowed = 0;
    }
    else {
        [self hideCardView];
        whoShowed = 3;
        [self openCardView];
    }
}

- (IBAction) onClickForth:(id)sender {
    
    if (whoShowed == 4) {
        [self hideCardView];
        whoShowed = 0;
    }
    else {
        [self hideCardView];
        whoShowed = 4;
        [self openCardView];
    }
}

- (IBAction) onClickFifth:(id)sender {
    
    if (whoShowed == 5) {
        [self hideCardView];
        whoShowed = 0;
    }
    else {
        [self hideCardView];
        whoShowed = 5;
        [self openCardView];
    }
}

- (IBAction) onClickSixth:(id)sender {
    
    if (whoShowed == 6) {
        [self hideCardView];
        whoShowed = 0;
    }
    else {
        [self hideCardView];
        whoShowed = 6;
        [self openCardView];
    }
}

#pragma mark-   LevyTabBarControllerDelegate

- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    NSLog(@"TabWallet Selected");
    [SHAREDMANAGER serverCall].delegate = self;
    [[SHAREDMANAGER serverCall] requestServer:[NSString stringWithFormat:@"https://dashboard.ontab.com/api/cards?access_token=%@", [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"]]];

}



#pragma mark -
#pragma mark OActionDelegate Methods
- (void)pressedButton:(id)sender
{
    int tag = (int) [sender tag];
    switch (tag) {
        case kLeftBarButtonItem: {
            
        }   break;
        case kRightBarButtonItem:
            
            break;
    }
}

#pragma mark - ServerCallDelegate

- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    mArrCards = [NSArray arrayWithArray:(NSArray*)dictData];
    if (mArrCards != nil) {
        for (int i=0; i<mArrCards.count; i++) {
            NSDictionary*   dict = [mArrCards objectAtIndex:i];
            UIView* vCard = (UIView*) [vCnt viewWithTag:i+1];
            UIButton*   btn = (UIButton*) [vCard viewWithTag:1000];
            if ([[dict objectForKey:@"card_type"] isEqualToString:@"mastercard"]) {
                [btn setImage:[UIImage imageNamed:@"wallet_card_master"] forState:UIControlStateNormal];
            } else if ([[dict objectForKey:@"card_type"] isEqualToString:@"visa"]) {
                [btn setImage:[UIImage imageNamed:@"wallet_card_visa"] forState:UIControlStateNormal];
            }
        }
        for (int i=mArrCards.count; i<6; i++) {
            UIView* vCard = (UIView*) [vCnt viewWithTag:i+1];
            vCard.hidden = YES;
        }
        

        for (int i=0; i<mArrCards.count; i++) {
            NSDictionary*   dict = [mArrCards objectAtIndex:i];
            UIView* vCard = [scrlView viewWithTag:i+1];\
            NSLog(@"%@", [SHAREDMANAGER dictCards]);
            for (UITextField* tfFld in vCard.subviews) {
                if ([tfFld isKindOfClass:[UITextField class]])
                {
                    NSLog(@"%@", [[SHAREDMANAGER dictCards] objectForKey:[NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]]]);
                    tfFld.text = [[SHAREDMANAGER dictCards] objectForKey:[NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]]];
                }
            }
        }
        
    } else {
        NSLog(@"JSon Parse Error!");
        [Utilities showMsg:[dictData objectForKey:@"errormsg"]];
    }
}

@end
