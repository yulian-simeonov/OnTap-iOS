//
//  WaitingBillViewController.h
//  OnTab
//
//  Created by ZhenLiu on 11/20/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OViewController.h"

@interface WaitingBillViewController : OViewController

@property (nonatomic, readwrite) int ontabId;
@property (nonatomic, strong) NSString*  displayInfo;

@end
