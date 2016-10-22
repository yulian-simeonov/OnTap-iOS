//
//  HistoryCell.h
//  OnTab
//
//  Created by ZhenLiu on 12/10/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblCardBrand;
@property (weak, nonatomic) IBOutlet UILabel *lblLastfour;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchant;
@property (weak, nonatomic) IBOutlet UILabel *lblOrp;

@end
