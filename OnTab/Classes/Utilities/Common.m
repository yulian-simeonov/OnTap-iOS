//
//  Common.m
//  StyledFriend
//
//  Created by Jungrak Lee on 9/27/12.
//  Copyright (c) 2012 orfeostory, inc. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (UIImage *)medalImageForRank:(NSString *)rank
{
    UIImage *image = nil;
    
    if ([rank isEqualToString:@"SILVER"]) {
        image = [UIImage imageNamed:@"bedge_silver"];
    } else if ([rank isEqualToString:@"GOLD"]) {
        image = [UIImage imageNamed:@"bedge_gold"];
    }
    
    return image;
}

+ (BOOL)isLargeScreeniPhone
{
    BOOL returnValue = NO;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    if (screenBounds.size.height > 480) {
        returnValue = YES;
    }
    
    return returnValue;
}

+ (CGFloat)diffScreenHeight
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    return screenBounds.size.height - 480;
}

+ (void)adjustViewPosition:(UIView *)view
{
    if ([Common isLargeScreeniPhone]) {
        CGRect frame = view.frame;
        
        frame.origin.y +=  [Common diffScreenHeight];
        
        view.frame = frame;
    }
}

+ (void)adjustViewPositionToCentre:(UIView *)view
{
    if ([Common isLargeScreeniPhone]) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        
        CGPoint centre = CGPointMake(screenBounds.size.width/2, screenBounds.size.height/2);
        
        view.center = centre;
    }
}

+ (void)adjustViewSize:(UIView *)view
{
    if ([Common isLargeScreeniPhone]) {
        CGRect frame = view.frame;
        
        frame.size.height += [Common diffScreenHeight];
        
        view.frame = frame;
    }
}


@end
