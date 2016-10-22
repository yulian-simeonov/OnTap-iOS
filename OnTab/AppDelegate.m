//
//  AppDelegate.m
//  OnTab
//
//  Created by ZhenLiu on 11/18/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import "AppDelegate.h"

#import "OViewController.h"
#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "PlaceViewController.h"
#import "DiscoverViewController.h"
#import "WalletViewController.h"
#import "SplashViewController.h"
#import "LeveyTabBarController.h"
#import "CardsViewController.h"

@implementation AppDelegate

@synthesize leveyTabBarController, strCardPwd, dictCards;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[SharedManager sharedManager] loadSessionFromDisk];
    [SHAREDMANAGER loadUserSetting];
    [SHAREDMANAGER loadCards];
    
    SplashViewController*   vcSplash = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    self.window.rootViewController = vcSplash;
    
    return YES;
}

- (void)didLogIn
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    OViewController *viewController1, *viewController2, *viewController3, *viewController4  = nil;
    UINavigationController *navController1, *navController2, *navController3, *navController4 = nil;
    
    // FeedViewController
    viewController1 = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    navController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    [viewControllers addObject:navController1];
    
    NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic1 setObject:[UIImage imageNamed:@"tabitem_profile"] forKey:@"Default"];
	[imgDic1 setObject:[UIImage imageNamed:@"tabitem_profile_h"] forKey:@"Highlighted"];
	[imgDic1 setObject:[UIImage imageNamed:@"tabitem_profile_h"] forKey:@"Seleted"];
    
    viewController2 = [[DiscoverViewController alloc] initWithNibName:@"DiscoverViewController" bundle:nil];
    navController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    [viewControllers addObject:navController2];
    
    NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic2 setObject:[UIImage imageNamed:@"tabitem_discover"] forKey:@"Default"];
	[imgDic2 setObject:[UIImage imageNamed:@"tabitem_discover_h"] forKey:@"Highlighted"];
	[imgDic2 setObject:[UIImage imageNamed:@"tabitem_discover_h"] forKey:@"Seleted"];
    
    viewController3 = [[PlaceViewController alloc] initWithNibName:@"PlaceViewController" bundle:nil];
    navController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    [viewControllers addObject:navController3];
    
    NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic3 setObject:[UIImage imageNamed:@"tabitem_place"] forKey:@"Default"];
	[imgDic3 setObject:[UIImage imageNamed:@"tabitem_place_h"] forKey:@"Highlighted"];
	[imgDic3 setObject:[UIImage imageNamed:@"tabitem_place_h"] forKey:@"Seleted"];
    
    viewController4 = [[CardsViewController alloc] initWithNibName:@"CardsViewController" bundle:nil];
    navController4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
    [viewControllers addObject:navController4];
    
    NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic4 setObject:[UIImage imageNamed:@"tabitem_wallet"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"tabitem_wallet_h"] forKey:@"Highlighted"];
	[imgDic4 setObject:[UIImage imageNamed:@"tabitem_wallet_h"] forKey:@"Seleted"];
    
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    tabBarController.delegate = self;
//    tabBarController.viewControllers = viewControllers;
//    tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
//    _window.rootViewController = tabBarController;
//    
//    UITabBarItem *tabBarItem1 = [tabBarController.tabBar.items objectAtIndex:0];
//    tabBarItem1.selectedImage = [[UIImage imageNamed:@"tabitem_profile"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    tabBarItem1.image = [[UIImage imageNamed:@"tabitem_profile_h"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    tabBarItem1.title = nil;
    
    
    NSArray *imgArr = [NSArray arrayWithObjects:imgDic1,imgDic2,imgDic3, imgDic4, nil];
    
    self.leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:viewControllers imageArray:imgArr];
	[leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg@2x.png"]];
	[leveyTabBarController setTabBarTransparent:YES];
    
    _window.rootViewController = self.leveyTabBarController;
    
}

+ (AppDelegate*) sharedAppDelegate {

    return (AppDelegate *) [UIApplication sharedApplication].delegate;    
}

- (void)didLogOut
{
    LoginViewController*    vcLogin = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vcLogin];
    
    _window.rootViewController = navController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
