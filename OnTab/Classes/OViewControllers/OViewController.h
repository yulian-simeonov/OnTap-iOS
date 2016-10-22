//
//  OViewController.h
//  StyledFriend
//
//  Created by Jungrak Lee on 8/16/12.
//  Copyright (c) 2012 orfeostory, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OActionDelegate.h"

#import "Utilities.h"
//#import "OHttpClient.h"
//#import "OSettings.h"
//#import "OAlertView.h"

#import "CustomTags.h"
#import "CustomStrings.h"
#import "Common.h"

#import "AppDelegate.h"

#define kLeftBarButtonItem          9001
#define kRightBarButtonItem         9002

#define kTagPicker                  9011
#define kTagToolBar                 9012

#define kDefaultAnimationDuration   0.3f

@interface OViewController : UIViewController <OActionDelegate>
{
    AppDelegate *_delegate;
    
    NSString *_leftBarButtonImage;
    NSString *_rightBarButtonImage;
    NSString *_rightBarButtonString;
    BOOL _isModal;
    
    NSDictionary *_bundle;
}

@property (nonatomic, retain) AppDelegate *delegate;

@property (nonatomic, retain) NSString *leftBarButtonImage;
@property (nonatomic, retain) NSString *rightBarButtonImage;
@property (nonatomic, retain) NSString *rightBarButtonString;

@property (nonatomic) BOOL isModal;

@property (nonatomic, retain) NSDictionary *bundle;

@end
