//
//  Common.h
//  StyledFriend
//
//  Created by Jungrak Lee on 9/27/12.
//  Copyright (c) 2012 orfeostory, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (UIImage *)medalImageForRank:(NSString *)rank;

+ (BOOL)isLargeScreeniPhone;
+ (CGFloat)diffScreenHeight;
+ (void)adjustViewPosition:(UIView *)view;
+ (void)adjustViewPositionToCentre:(UIView *)view;
+ (void)adjustViewSize:(UIView *)view;

@end
