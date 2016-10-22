//
//  GeneralScrollViewController.m
//  CouponZip
//
//  Created by Jung Rak Lee on 6/5/11.
//  Copyright 2011 orfeostory™, inc. All rights reserved.
//

#import "OTextViewController.h"

#define kKeyboardHeight     216
#define kPickerHeight       (216 + 44)

@implementation OTextViewController

@synthesize scrollView = _scrollView;
@synthesize picker = _picker;

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.scrollView = nil;
    _picker = nil;
}

- (void)removeKeyboardAnimated:(BOOL)animated
{
    int index = 0;
    for (; index < self.scrollView.subviews.count; index++) {
        UIView *subview = [self.scrollView.subviews objectAtIndex:index];
        
        if ([subview isKindOfClass:[UITextField class]] == YES || [subview isKindOfClass:[UITextView class]] == YES) {
            if ([subview isFirstResponder] == YES) {
                [subview resignFirstResponder];
                break;
            }
        }
    }
    
    if (index == self.scrollView.subviews.count) {
        return;
    }

    if (animated == NO) {
        return;
    }
    
    [self moveScrollView];
}

- (void)removePickerViewAnimated:(BOOL)animated
{
    if (_picker == nil) {
        return;
    }
    
    if (animated == NO) {
        [_picker removeFromSuperview];
        return;
    }
    
    [self hidePickerView];
    
    [self moveScrollView];
}

- (void)removeKeyboardAndPickerView
{
    [self removeKeyboardAnimated:YES];
    
    [self removePickerViewAnimated:YES];
}

- (NSDate *)selectedPickerDate
{
    for (UIView *subview in self.picker.subviews) {
        if ([subview isKindOfClass:[UIDatePicker class]] == YES) {
            return [(UIDatePicker *)subview date];
        }
    }
    
    return nil;
}

- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    for (UIView *subview in self.picker.subviews) {
        if ([subview isKindOfClass:[UIPickerView class]] == YES) {
            return [((UIPickerView *)subview) selectedRowInComponent:component];
        }
    }

    return -1;
}

- (void)moveScrollView
{
    CGFloat scrollAmount = 0;
    
    if (self.scrollView.contentSize.height == 0) {
        scrollAmount = 0;
    } else if (self.scrollView.contentOffset.y + self.scrollView.frame.size.height > self.scrollView.contentSize.height) {
        scrollAmount = self.scrollView.contentSize.height - self.scrollView.frame.size.height;
    } else {
        scrollAmount = self.scrollView.contentOffset.y;
    }
    
    [self.scrollView setContentOffset:CGPointMake(0, scrollAmount) animated:YES];
}

- (void)moveScrollView:(UIView *)view forMethod:(NSInteger)method {
    CGFloat viewOffsetY = view.frame.origin.y + view.frame.size.height;
    
    CGFloat freeSpaceHeight = self.scrollView.frame.size.height;
    
    if (method == kMethodKeyboard) {
        freeSpaceHeight -= kKeyboardHeight;
    } else {
        freeSpaceHeight -= kPickerHeight;
    }
    
    CGFloat scrollAmount = viewOffsetY - freeSpaceHeight;
    
    if (scrollAmount < 0) scrollAmount = 0;
        
    [self.scrollView setContentOffset:CGPointMake(0, scrollAmount) animated:YES];
}

- (void)showPickerView
{
    [self removeKeyboardAnimated:NO];
}

- (void)hidePickerView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kDefaultAnimationDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishAnimation:finished:context:)];
    
    self.picker.frame = CGRectMake(0, self.view.frame.size.height, self.picker.frame.size.width, self.picker.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)finishAnimation:(NSString *)animationId finished:(BOOL)finished context:(void *)context
{
    [_picker removeFromSuperview];
    
    _picker = nil;
}

#pragma mark -
#pragma mark Scroll View Delegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeKeyboardAnimated:NO];
    
    if (_picker != nil) {
        [self hidePickerView];
    }
}

#pragma mark -
#pragma mark Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self removePickerViewAnimated:YES];

    [self moveScrollView:textField forMethod:kMethodKeyboard];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self moveScrollView];
    [textField resignFirstResponder];
    return YES;
}

@end
