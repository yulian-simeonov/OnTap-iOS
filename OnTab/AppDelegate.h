//
//  AppDelegate.h
//  OnTab
//
//  Created by Yulian on 11/18/13.
//  Copyright (c) 2013 Yulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeveyTabBarController;
#import "OActionDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain)       LeveyTabBarController       *leveyTabBarController;
@property (nonatomic, strong) NSString* strCardPwd;
@property (nonatomic, strong) NSMutableDictionary*  dictCards;

+ (AppDelegate*) sharedAppDelegate;
- (void)didLogIn;
- (void)didLogOut;

@end
