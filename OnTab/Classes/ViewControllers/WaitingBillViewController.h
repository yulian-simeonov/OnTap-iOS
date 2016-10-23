//
//  WaitingBillViewController.h
//  OnTab
//
//  Created by Yulian on 11/20/13.
//  Copyright (c) 2013 Yulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OViewController.h"

@interface WaitingBillViewController : OViewController

@property (nonatomic, readwrite) int ontabId;
@property (nonatomic, strong) NSString*  displayInfo;

@end
