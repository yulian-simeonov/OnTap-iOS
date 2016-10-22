//
//  SplashViewController.m
//  OnTab
//
//  Created by ZhenLiu on 11/19/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController () <ServerCallDelegate> {

    IBOutlet UIImageView*   ivSplash;
}

@end

@implementation SplashViewController

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
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(onCompletionAnim:) userInfo:nil repeats:NO];
}

- (void) onCompletionAnim:(id)sender {

    if ( ![[[SharedManager sharedManager] sessionDictionay] isKindOfClass:[NSNull class]]
        && ![[[SharedManager sharedManager] sessionDictionay] isEqual:nil] )
    {
        if([[[[SharedManager sharedManager] sessionDictionay] objectForKey:@"IsLoggedInAlready"] boolValue])
        {
            [SHAREDMANAGER serverCall].delegate = self;
            
            NSLog(@"%@", [SHAREDMANAGER sessionDictionay]);
            
            NSDictionary* dictParam = [NSDictionary dictionaryWithObjectsAndKeys:@"password", @"grant_type", [[SHAREDMANAGER sessionDictionay] objectForKey:@"username"], @"username", [[SHAREDMANAGER sessionDictionay] objectForKey:@"password"], @"password", kClientId, @"client_id", kSecretId, @"client_secret", nil];
            
            [[SHAREDMANAGER serverCall] requestServerOnPost:@"https://dashboard.ontab.com/oauth/token?" data:dictParam];
        } else {
            [APPDELEGATE didLogOut];
        }
    } else {
        [APPDELEGATE didLogOut];
    }
}

- (void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    NSMutableArray*     arr = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        NSString* strName = [NSString stringWithFormat:@"splash_%d", i+1];
        [arr addObject:[UIImage imageNamed:strName]];
    }
    ivSplash.animationImages = arr;
    ivSplash.animationDuration = 1.0;
    ivSplash.animationRepeatCount = 3;
    [ivSplash startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    if ([dictData objectForKey:@"access_token"] != nil) {
        NSLog(@"%@", [SHAREDMANAGER sessionDictionay]);
        
        NSMutableDictionary* data = (NSMutableDictionary*) dictData;
        [data setObject:@YES forKey:@"IsLoggedInAlready"];
        [data setObject:[[SHAREDMANAGER sessionDictionay] objectForKey:@"username"] forKey:@"username"];
        [data setObject:[[SHAREDMANAGER sessionDictionay] objectForKey:@"password"] forKey:@"password"];
        
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
