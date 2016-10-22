//
//  SuccessViewController.h
//  OnTab
//
//  Created by ZhenLiu on 11/21/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OViewController.h"

@interface SuccessViewController : OViewController

@property (nonatomic, readwrite) BOOL   isSuccess;
@property (nonatomic, strong)       NSDictionary*   dictDetail;

@end
