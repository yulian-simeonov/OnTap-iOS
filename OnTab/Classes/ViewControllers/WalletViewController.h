//
//  WalletViewController.h
//  OnTab
//
//  Created by ZhenLiu on 11/19/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OViewController.h"

@interface WalletViewController : OViewController

@property (nonatomic, readwrite) int  nInvoiceId;
@property (nonatomic, strong) NSDictionary* dictDetail;
@end
