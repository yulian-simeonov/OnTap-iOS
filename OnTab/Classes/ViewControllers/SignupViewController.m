//
//  SignupViewController.m
//  OnTab
//
//  Created by ZhenLiu on 11/19/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController () <ServerCallDelegate> {

    IBOutlet UITextField*   tfEmail;
    IBOutlet UITextField*   tfPass;
    IBOutlet UITextField*   tfPassCfrm;
    
    BOOL isLoginApi;
}

@end

@implementation SignupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"CREATE ACCOUNT";
        [self setLeftBarButtonImage:@"btn_back"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isLoginApi = NO;
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

- (IBAction) onClickSignup:(id)sender {
    
    if (![Utilities isValidString:tfPass.text] || ![Utilities isValidString:tfPassCfrm.text]) {
        [Utilities showMsg:@"Please input field"];
        return;
    }
    if (tfPass.text.length < 8 || tfPassCfrm.text.length < 8) {
        [Utilities showMsg:@"Password should be more than 8"];
        return;
    }
    if (![Utilities validateEmailWithString:tfEmail.text]) {
        [Utilities showMsg:@"Please input valid email"];
        return;
    }
    if (![tfPassCfrm.text isEqualToString:tfPass.text]) {
        [Utilities showMsg:@"Confirm password is wrong"];
        return;
    }
    
    [SHAREDMANAGER serverCall].delegate = self;
    
    NSDictionary* dictParam = [NSDictionary dictionaryWithObjectsAndKeys:tfEmail.text, @"email", tfPass.text, @"password", tfPassCfrm.text, @"password_confirmation", nil];
    
    NSLog(@"%@", dictParam);
    
    [[SHAREDMANAGER serverCall] requestServerOnPost:@"https://dashboard.ontab.com/api/users?" data:dictParam];
}

#pragma mark -
#pragma mark OActionDelegate Methods
- (void)pressedButton:(id)sender
{
    int tag = (int) [sender tag];
    switch (tag) {
        case kLeftBarButtonItem: {
            [self.navigationController popViewControllerAnimated:YES];
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
    if (dictData != nil) {
        NSLog(@"%@", [SHAREDMANAGER sessionDictionay]);
        if (isLoginApi) {
            if ([dictData objectForKey:@"access_token"] != nil) {
                NSLog(@"%@", [SHAREDMANAGER sessionDictionay]);
                
                NSMutableDictionary* data = (NSMutableDictionary*) dictData;
                [data setObject:@YES forKey:@"IsLoggedInAlready"];
                [data setObject:tfEmail.text forKey:@"username"];
                [data setObject:tfPass.text forKey:@"password"];
                
                [[SharedManager sharedManager] setSessionDictionay:[NSDictionary dictionaryWithDictionary:data]
                 ];
                [[SharedManager sharedManager] saveSessionToDisk];
                
                NSLog(@"%@", [SHAREDMANAGER sessionDictionay]);
                [APPDELEGATE didLogIn];
            }
        } else {
            isLoginApi = YES;
            [SHAREDMANAGER serverCall].delegate = self;
            
            NSDictionary* dictParam = [NSDictionary dictionaryWithObjectsAndKeys:@"password", @"grant_type", tfEmail.text, @"username", tfPass.text, @"password", kClientId, @"client_id", kSecretId, @"client_secret", nil];
            
            NSLog(@"%@", dictParam);
            
            [[SHAREDMANAGER serverCall] requestServerOnPost:@"https://dashboard.ontab.com/oauth/token?" data:dictParam];
        }
        
    } else {
        NSLog(@"JSon Parse Error!");
        [Utilities showMsg:[dictData objectForKey:@"errormsg"]];
    }
}

@end
