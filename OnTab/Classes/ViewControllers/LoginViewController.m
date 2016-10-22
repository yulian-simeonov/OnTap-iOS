//
//  LoginViewController.m
//  OnTab
//
//  Created by ZhenLiu on 11/19/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"
#import "SVProgressHUD.h"

@interface LoginViewController () <UITextFieldDelegate, ServerCallDelegate> {

    IBOutlet UITextField*   tfEmail;
    IBOutlet UITextField*   tfPwd;
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"SIGN IN";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [[SharedManager sharedManager] serverCall].methodType = @"POST";
//    [[SharedManager sharedManager] serverCall].urlStr = @"http://dashboard.ontab.com/oauth/token";
//    [[[SharedManager sharedManager] serverCall] getOauthDataUsingHMAC];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark UIButtonActionDelegate Methods

- (IBAction) onClickLogin:(id)sender {

//    NSString *strUrl = [NSString stringWithFormat:@"%@%@", kBaseUrl, kAPI_Register];
    [SHAREDMANAGER serverCall].delegate = self;
    
    NSDictionary* dictParam = [NSDictionary dictionaryWithObjectsAndKeys:@"password", @"grant_type", tfEmail.text, @"username", tfPwd.text, @"password", kClientId, @"client_id", kSecretId, @"client_secret", nil];
    
    NSLog(@"%@", dictParam);
    
    [[SHAREDMANAGER serverCall] requestServerOnPost:@"https://dashboard.ontab.com/oauth/token?" data:dictParam];
    
//    [APPDELEGATE didLogIn];
}

- (IBAction) onClickSignup:(id)sender {

    SignupViewController*   vcSignup = [[SignupViewController alloc] initWithNibName:@"SignupViewController" bundle:nil];
    [self.navigationController pushViewController:vcSignup animated:YES];
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

/*
{
    "access_token" = d9e33a5e199069412b257d466bf02d36cb429795371f0e4c87cbb3704f681efe;
    "expires_in" = 7200;
    "token_type" = bearer;
}
*/

- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    if ([dictData objectForKey:@"access_token"] != nil) {
        NSLog(@"%@", [SHAREDMANAGER sessionDictionay]);
        
        NSMutableDictionary* data = (NSMutableDictionary*) dictData;
        [data setObject:@YES forKey:@"IsLoggedInAlready"];
        [data setObject:tfEmail.text forKey:@"username"];
        [data setObject:tfPwd.text forKey:@"password"];
        
        [[SharedManager sharedManager] setSessionDictionay:[NSDictionary dictionaryWithDictionary:data]
         ];
        [[SharedManager sharedManager] saveSessionToDisk];

                NSLog(@"%@", [SHAREDMANAGER sessionDictionay]);
        [APPDELEGATE didLogIn];
    } else {
        NSLog(@"JSon Parse Error!");
        [Utilities showMsg:[dictData objectForKey:@"errormsg"]];
    }
}

@end
