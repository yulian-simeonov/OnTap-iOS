//
//  GeneralScrollViewController.h
//  CouponZip
//
//  Created by Jung Rak Lee on 6/5/11.
//  Copyright 2011 orfeostory™, inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OViewController.h"

#define kMethodKeyboard     1
#define kMethodPicker       2

@interface OTextViewController : OViewController <UIScrollViewDelegate, UITextFieldDelegate> {
    UIView *_picker;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) UIView *picker;

- (void)removeKeyboardAnimated:(BOOL)animated;
- (void)removePickerViewAnimated:(BOOL)animated;
- (void)removeKeyboardAndPickerView;

- (NSDate *)selectedPickerDate;
- (NSInteger)selectedRowInComponent:(NSInteger)component;

- (void)moveScrollView;
- (void)moveScrollView:(UIView *)view forMethod:(NSInteger)method;

- (void)showPickerView;
- (void)hidePickerView;

- (void)finishAnimation:(NSString *)animationId finished:(BOOL)finished context:(void *)context;

@end
