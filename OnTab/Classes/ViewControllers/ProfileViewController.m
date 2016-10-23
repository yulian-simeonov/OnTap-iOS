//
//  ProfileViewController.m
//  OnTab
//
//  Created by Yulian on 11/19/13.
//  Copyright (c) 2013 Yulian. All rights reserved.
//

#import "ProfileViewController.h"
#import "SVProgressHUD.h"
#import "HistoryCell.h"

@interface ProfileViewController () <UITextFieldDelegate, ServerCallDelegate, UITableViewDataSource, UITableViewDelegate> {

    IBOutlet UIScrollView*  scrlView;
    IBOutlet UIView*    vProfile;
    IBOutlet UIView*    vCredit;
    IBOutlet UIView*    vHistory;
    IBOutlet UIButton*  btnProfile;
    
    IBOutlet UITableView*   tblCardHistory;
    
    NSArray*    mArrCardHistory;
    NSArray*    mArrCards;
    IBOutlet UILabel*   lblCardsCount;
    IBOutlet UILabel*   lblEmail;
    IBOutlet UILabel*   lblName;
    
    IBOutlet UIButton*  btnOntab;
    
    BOOL isCardHistoryAPI;
    
    BOOL isGetCardsAPI;
    BOOL isAddCardAPI;
}
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfTempCardToken;
@property (weak, nonatomic) IBOutlet UITextField *tfCardPwd;

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"PROFILE";
//        [self setLeftBarButtonImage:@"btn_back"];
        [self setRightBarButtonImage:@"btn_ontab"];
    }
    return self;
}

- (FSNConnection *) makeIsFbConnection {
    [SVProgressHUD show];
    NSURL *url = [NSURL URLWithString:@"https://dashboard.ontab.com/api/customer"];
    
    // to make a successful foursquare api request, add your own api credentials here.
    // for more information see: https://developer.foursquare.com/overview/auth
    
    NSDictionary *parameters =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"],                  @"access_token",
     nil];
    
    return [FSNConnection withUrl:url
                           method:FSNRequestMethodGET
                          headers:nil
                       parameters:parameters
                       parseBlock:^id(FSNConnection *c, NSError **error) {
                           NSDictionary *d = [c.responseData dictionaryFromJSONWithError:error];
                           if (!d) return nil;
                           
                           // example error handling.
                           // since the demo ships with invalid credentials,
                           // running it will demonstrate proper error handling.
                           // in the case of the 4sq api, the meta json in the response holds error strings,
                           // so we create the error based on that dictionary.
                           if (c.response.statusCode != 200) {
                               *error = [NSError errorWithDomain:@"FSAPIErrorDomain"
                                                            code:1
                                                        userInfo:[d objectForKey:@"meta"]];
                           }
                           
                           return d;
                       }
                  completionBlock:^(FSNConnection *c) {
                      NSLog(@"complete: %@\n\nerror: %@\n\n", c, c.error);
                      NSLog(@"Response:%@", [c.parseResult description]);
                      [SVProgressHUD dismiss];
                      
                      _tfName.text = [NSString stringWithFormat:@"%@ %@ %@", [(NSDictionary*) c.parseResult objectForKey:@"first_name"], [(NSDictionary*) c.parseResult objectForKey:@"last_name"], [(NSDictionary*) c.parseResult objectForKey:@"middle_name"]];
                    }
                    progressBlock:^(FSNConnection *c) {
                        NSLog(@"progress: %@: %.2f/%.2f", c, c.uploadProgress, c.downloadProgress);
                        [SVProgressHUD dismiss];
                    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"view size : %@", NSStringFromCGRect(self.view.frame));
    [scrlView addSubview:vProfile];
    [scrlView addSubview:vCredit];
    [scrlView addSubview:vHistory];
    isCardHistoryAPI = NO;
    
    vProfile.hidden = NO;
    vCredit.hidden = YES;
    vHistory.hidden = YES;
    
    lblEmail.text = [[SHAREDMANAGER sessionDictionay] objectForKey:@"username"];
    lblName.text = [[SHAREDMANAGER sessionDictionay] objectForKey:@"username"];
    
    FSNConnection*  connection = [self makeIsFbConnection];
    [connection start];
}

- (void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    isGetCardsAPI = YES;
    isCardHistoryAPI = NO;
    isAddCardAPI = NO;
    
    if ([[[SHAREDMANAGER userSetting] objectForKey:@"OpenTab"] isEqualToString:@"checkin"]) {
        [btnOntab setBackgroundImage:[UIImage imageNamed:@"btn_switchon"] forState:UIControlStateNormal];
        
    } else {
        [btnOntab setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
    }
    
//    [SHAREDMANAGER serverCall].delegate = self;
//    [[SHAREDMANAGER serverCall] requestServer:[NSString stringWithFormat:@"https://dashboard.ontab.com/api/cards?access_token=%@", [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"]]];
//    NSLog(@"view size : %@", NSStringFromCGRect(self.view.frame));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = -100;
        self.view.frame = frame;
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 64;
        self.view.frame = frame;
    }];
    
    [textField resignFirstResponder];
    if (textField == _tfCardPwd)
        APPDELEGATE.strCardPwd = _tfCardPwd.text;
    return YES;
}

#pragma mark - UIButtonActionDelegate

- (IBAction) onClickMenuButton:(id)sender {

    NSArray*  arrImgNor = [NSArray arrayWithObjects:@"group_profile", @"group_credit", @"group_history", nil];
    NSArray*  arrImgSel = [NSArray arrayWithObjects:@"group_profile_h", @"group_credit_h", @"group_history_h", nil];
    for (int i=0; i<3; i++) {
        UIButton*   btn = (UIButton*) [self.view viewWithTag:i+1];
        [btn setImage:[UIImage imageNamed:[arrImgNor objectAtIndex:i]] forState:UIControlStateNormal];
    }
    [sender setImage:[UIImage imageNamed:[arrImgSel objectAtIndex:[sender tag]-1]] forState:UIControlStateNormal];
    vProfile.hidden = YES;
    vCredit.hidden = YES;
    vHistory.hidden = YES;
    switch ([sender tag]) {
        case 1: {
            vProfile.hidden = NO;
        }
            break;
        case 2:
            vCredit.hidden = NO;
            
            break;
        case 3: {
            vHistory.hidden = NO;
            [SHAREDMANAGER serverCall].delegate = self;
            isGetCardsAPI = NO;
            isAddCardAPI = NO;
            isCardHistoryAPI = YES;
            [[SHAREDMANAGER serverCall] requestServer:[NSString stringWithFormat:@"https://dashboard.ontab.com/api/charges?access_token=%@", [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"]]];
        }
            break;
        default:
            break;
    }
}

- (IBAction) onClickSubmit:(id)sender {

    isGetCardsAPI = NO;
    isAddCardAPI = NO;
    isCardHistoryAPI = NO;
    
    [SHAREDMANAGER serverCall].delegate = self;
    [SHAREDMANAGER serverCall].nTag = 100;
    
    NSArray* arrName = [_tfName.text componentsSeparatedByString:@" "];
    NSString* strFName=@"", *strMName=@"", *strLName=@"";
    if (arrName.count == 0) {
        [Utilities showMsg:@"Input the name first!"];
        return;
    }
    if (arrName.count == 1)
        strFName = [arrName objectAtIndex:0];
    else if (arrName.count == 2) {
        strFName = [arrName objectAtIndex:0];
        strMName = [arrName objectAtIndex:1];
    } else {
        strFName = [arrName objectAtIndex:0];
        strMName = [arrName objectAtIndex:1];
        strLName = [arrName objectAtIndex:2];
    }
    
    [[SHAREDMANAGER serverCall] requestServer:[NSString stringWithFormat:@"https://dashboard.ontab.com/api/customer?access_token=%@&first_name=%@&middle_name=%@&last_name=%@", [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"], strFName, strMName, strLName]];
}

- (IBAction) onClickSwitch:(id)sender {
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:[SHAREDMANAGER userSetting]];
    if ([[[SHAREDMANAGER userSetting] objectForKey:@"OpenTab"] isEqualToString:@"random"]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchon"] forState:UIControlStateNormal];
        [dict setObject:@"checkin" forKey:@"OpenTab"];

    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
        [dict setObject:@"random" forKey:@"OpenTab"];
    }
    
    [SHAREDMANAGER setUserSetting:(NSDictionary*)dict];
    [SHAREDMANAGER saveUserSetting];
}

- (IBAction) onClickAddNew:(id)sender {

    isAddCardAPI = YES;
    isGetCardsAPI = NO;
    isCardHistoryAPI = NO;
    [SHAREDMANAGER serverCall].delegate = self;
    
    NSDictionary* dictParam = [NSDictionary dictionaryWithObjectsAndKeys:[[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"], @"access_token", _tfTempCardToken.text, @"temp_card_token", nil];
    
    NSLog(@"%@", dictParam);
    
    [[SHAREDMANAGER serverCall] requestServerOnPost:@"https://dashboard.ontab.com/api/cards?" data:dictParam];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return mArrCardHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == tblCardHistory) {
        static NSString* strIdentiCate = @"HistoryCell";
        HistoryCell*    cell = (HistoryCell*) [tableView dequeueReusableCellWithIdentifier:strIdentiCate];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:self options:nil] objectAtIndex:0];
        }
        NSDictionary*   dict = [mArrCardHistory objectAtIndex:indexPath.row];
        cell.lblDate.text = [[[dict objectForKey:@"date_time"] componentsSeparatedByString:@"T"] objectAtIndex:0];
        cell.lblCardBrand.text = [dict objectForKey:@"card_brand"];
        cell.lblLastfour.text = [dict objectForKey:@"card_last4"];
        cell.lblAmount.text = [NSString stringWithFormat:@"$%@", [dict objectForKey:@"amount"]];
        cell.lblMerchant.text = [dict objectForKey:@"merchant"];
        return cell;
    } else {
        static NSString* strIdentiCate = @"CardHistoryTableView";
        UITableViewCell*    cell = [tableView dequeueReusableCellWithIdentifier:strIdentiCate];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentiCate];
        }
        
        return cell;
    }
}

#pragma mark-   LevyTabBarControllerDelegate

- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    NSLog(@"TabProfile Selected");
    isGetCardsAPI = YES;
    isAddCardAPI = NO;
    isCardHistoryAPI = NO;
    [SHAREDMANAGER serverCall].delegate = self;
    [[SHAREDMANAGER serverCall] requestServer:[NSString stringWithFormat:@"https://dashboard.ontab.com/api/cards?access_token=%@", [[SHAREDMANAGER sessionDictionay] objectForKey:@"access_token"]]];
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
        if ([SHAREDMANAGER serverCall].nTag == 101) {
            
        } else {
            if (isCardHistoryAPI) {
                mArrCardHistory = [NSArray arrayWithArray:(NSArray*)dictData];
                [tblCardHistory reloadData];
            } else if (isGetCardsAPI) {
                mArrCards = [NSArray arrayWithArray:(NSArray*)dictData];
                lblCardsCount.text = [NSString stringWithFormat:@"%d", (int) mArrCards.count];
            } else if (isAddCardAPI) {
//                if ([dictData objectForKey:@"errors"] != nil) {
                    if ([[dictData objectForKey:@"errors"] objectAtIndex:0] != nil)
                        [Utilities showMsg:[[dictData objectForKey:@"errors"] objectAtIndex:0]];
                    else {
                        NSMutableDictionary*    dict = [NSMutableDictionary dictionaryWithDictionary:[[SharedManager sharedManager] dictCards]];
                        NSString*   strCardId = [NSString stringWithFormat:@"%@", [dictData objectForKey:@"id"]];
                        [dict setObject:_tfCardPwd.text forKey:strCardId];
                        
                        [SHAREDMANAGER setDictCards:dict];
                        
                        [SHAREDMANAGER saveCards];
                        NSLog(@"%@", [SHAREDMANAGER dictCards]);
                    }
                    [Utilities showMsg:@"Successfully Added"];
                [_tfCardPwd resignFirstResponder];
                [_tfTempCardToken resignFirstResponder];
//                }
            }
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
