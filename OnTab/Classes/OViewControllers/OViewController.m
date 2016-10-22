//
//  OViewController.m
//  StyledFriend
//
//  Created by Jungrak Lee on 8/16/12.
//  Copyright (c) 2012 orfeostory, inc. All rights reserved.
//

#import "OViewController.h"

@interface OViewController ()

@end

@implementation OViewController

@synthesize delegate = _delegate;
@synthesize leftBarButtonImage = _leftBarButtonImage;
@synthesize rightBarButtonImage = _rightBarButtonImage;
@synthesize rightBarButtonString = _rightBarButtonString;
@synthesize isModal = _isModal;
@synthesize bundle = _bundle;

- (void)setLeftBarButtonImage:(NSString *)leftBarButtonImage
{
    self.navigationItem.hidesBackButton = YES;

    _leftBarButtonImage = leftBarButtonImage;
        
    UIImage *norImage = [UIImage imageNamed:[_leftBarButtonImage stringByAppendingString:@""]];
//    UIImage *highImage = [UIImage imageNamed:[_leftBarButtonImage stringByAppendingString:@"_high"]];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, norImage.size.width, norImage.size.height)];
    button.tag = kLeftBarButtonItem;
    
    [button setImage:norImage forState:UIControlStateNormal];
//    [button setImage:highImage forState:UIControlStateHighlighted];

    [button addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setRightBarButtonImage:(NSString *)rightBarButtonImage
{
    _rightBarButtonImage = rightBarButtonImage;

    UIImage *norImage = [UIImage imageNamed:[_rightBarButtonImage stringByAppendingString:@""]];
//    UIImage *highImage = [UIImage imageNamed:[_rightBarButtonImage stringByAppendingString:@"_high"]];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, norImage.size.width, norImage.size.height)];
    button.tag = kRightBarButtonItem;
    
    [button setImage:norImage forState:UIControlStateNormal];
//    [button setImage:highImage forState:UIControlStateHighlighted];

    [button addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setRightBarButtonString:(NSString *)rightBarButton
{
    UIFont* font = [UIFont systemFontOfSize:20.0f];
    CGSize size = [rightBarButton sizeWithFont:font
                                  forWidth:320.0
                             lineBreakMode:NSLineBreakByClipping];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, self.navigationController.navigationBar.frame.size.height)];
    [button setTitle:rightBarButton forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:148/255.0f green:231/255.0f blue:255/255.0f alpha:1.0] forState:UIControlStateNormal];
    button.tag = kRightBarButtonItem;
    [button setTitleColor:[UIColor colorWithRed:13/255.0f green:180/255.0f blue:228/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    //    [button setImage:highImage forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.navigationItem != nil) {
        if (self.title.length > 0) {
            UILabel *label = [[UILabel alloc] init];
            label.text = self.title;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
            [label setTextAlignment:NSTextAlignmentCenter];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            
            [label sizeToFit];

            self.navigationItem.titleView = label;
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.bundle = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.navigationController != nil) {
        if (self.title != nil) {
            self.navigationController.navigationBarHidden = NO;
            
            if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] == YES) {
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bg"] forBarMetrics:UIBarMetricsDefault];
            }
            
            if (self.navigationController.childViewControllers.count > 1) {
//                self.leftBarButtonImage = [OUtils chineseButtonName:@"titlebar_btn_back"];
            } else if (self.isModal == YES) {
//                self.rightBarButtonImage = [OUtils chineseButtonName:@"titlebar_btn_cancel"];
            }
        } else {
            self.navigationController.navigationBarHidden = YES;
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (IBAction)pressedButton:(id)sender
{
    NSInteger tag = ((UIView *) sender).tag;
    
    switch (tag) {
        case kLeftBarButtonItem: {
            if (self.navigationController.childViewControllers.count > 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }   break;
        case kRightBarButtonItem:
            if (self.navigationController.childViewControllers.count == 1 && self.isModal == YES) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            break;
    }
}

//#pragma mark -
//#pragma mark HTTP Client Delegate Methods
//- (void)httpClient:(OHttpClient *)httpClient didExecuteWithResult:(NSDictionary *)result
//{
//    NSString *error = [result objectForKey:@"error"];
//    
//    if (error != nil) {
//        [OAlertView showWithTitle:kTitle_Error message:error buttonTitle:kText_OKay];
//    }
//}
//
//- (void)httpClient:(OHttpClient *)httpClient didFailWithError:(NSError *)error
//{
//    if (httpClient.synchronized == YES) {
//        [OAlertView showWithTitle:kTitle_Error message:kMessage_NetworkFailed buttonTitle:kText_OKay];
//    }
//}

@end
