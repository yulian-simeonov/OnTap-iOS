//
//  DiscoverViewController.h
//  OnTab
//
//  Created by Yulian on 11/19/13.
//  Copyright (c) 2013 Yulian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OViewController.h"

@interface DiscoverViewController : OViewController

@property (nonatomic, strong) NSMutableArray*       arrPosts;

- (void) onSetLocation;

@end
