//
//  LeveyTabBarControllerViewController.m
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import "LeveyTabBarController.h"
#import "LeveyTabBar.h"
#import "AppDelegate.h"
#import "Utilities.h"
#import "PopupView.h"

#define kTabBarHeight 49.0f     // 49.0f + 43.0f (POPUP Height)

static LeveyTabBarController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (LeveyTabBarController *)leveyTabBarController
{
	return leveyTabBarController;
}

@end

@interface LeveyTabBarController (private)
- (void)displayViewAtIndex:(NSUInteger)index;
@end

@implementation LeveyTabBarController

@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;
@synthesize animateDriect;

#pragma mark -
#pragma mark lifecycle
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr
{
	self = [super init];
	if (self != nil)
	{
        yTabPos = [[UIScreen mainScreen] bounds].size.height - kTabBarHeight;
        
		_viewControllers = [[NSMutableArray arrayWithArray:vcs] retain];
		
		_containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
		
        NSLog(@"%@", NSStringFromCGRect(_containerView.frame));
        
		_transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, yTabPos, 320.0f, _containerView.frame.size.height - kTabBarHeight)];
		_transitionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
        


		_tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, yTabPos, 320.0f, kTabBarHeight) buttonImages:arr];
        _tabBar.vcTabbarCtrl = self;
		_tabBar.delegate = self;
		
        leveyTabBarController = self;
        animateDriect = 0;
	}
	return self;
}

- (void)loadView
{
	[super loadView];
	
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
	self.view = _containerView;
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
    self.selectedIndex = 0;
    
}


- (void) addPopupView {

    mVPopup = (PopupView*) [[[NSBundle mainBundle] loadNibNamed:@"PopupView" owner:self options:nil] objectAtIndex:0];
    mVPopup.frame = CGRectMake(76, 568, 88, 43);
    mVPopup.hidden = NO;
    [mVPopup.btnCam addTarget:self action:@selector(onTapCamBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mVPopup.btnRoll addTarget:self action:@selector(onTapRollBtn:) forControlEvents:UIControlEventTouchUpInside];
}



- (void) onTapRollBtn:(id) sender {
    
    NSLog(@"Roll Tapped");
    [self hidePopupView:YES animated:NO];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void) onTapCamBtn:(id) sender {
    
   [self hidePopupView:YES animated:NO];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ( ![UIImagePickerController isSourceTypeAvailable: sourceType] ) {
        //            [self openLibrary: sender];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}


- (void) hidePopupView:(BOOL)yesOrNo animated:(BOOL)animated {
    
	if (yesOrNo == YES)
	{
		if (mVPopup.frame.origin.y == mVPopup.frame.size.height)
		{
			return;
		}
	}
	else
	{
		if (mVPopup.frame.origin.y == 0)
		{
			return;
		}
	}
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
        
		if (yesOrNo == YES)
		{
			mVPopup.frame = CGRectMake(mVPopup.frame.origin.x, 568, mVPopup.frame.size.width, mVPopup.frame.size.height);
		}
		else
		{
			mVPopup.frame = CGRectMake(mVPopup.frame.origin.x, 476, mVPopup.frame.size.width, mVPopup.frame.size.height);
		}
		[UIView commitAnimations];
	}
	else
	{
		if (yesOrNo == YES)
		{
			mVPopup.frame = CGRectMake(mVPopup.frame.origin.x, 568, mVPopup.frame.size.width, mVPopup.frame.size.height);
		}
		else
		{
			mVPopup.frame = CGRectMake(mVPopup.frame.origin.x, 476, mVPopup.frame.size.width, mVPopup.frame.size.height);
		}
	}
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	_tabBar = nil;
	_viewControllers = nil;
}

- (void)dealloc 
{
    _tabBar.delegate = nil;
	[_tabBar release];
    [_containerView release];
    [_transitionView release];
	[_viewControllers release];
    [super dealloc];
}

#pragma mark - instant methods

- (LeveyTabBar *)tabBar
{
	return _tabBar;
}

- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}

- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, yTabPos, 320.0f, _containerView.frame.size.height - kTabBarHeight);
	}
}

- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
{
    float temp = kTabBarHeight;
    self.tabBarHidden = yesOrNO;
    
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else 
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - temp)
		{
			return;
		}
	}
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
        
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + temp, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - temp, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		[UIView commitAnimations];
	}
	else 
	{
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + temp, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - temp, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
	}
}

- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}
- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    
    [_tabBar selectTabAtIndex:index];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    [[(UIViewController *)[_viewControllers objectAtIndex:index] view] removeFromSuperview];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
    [_tabBar removeTabAtIndex:index];
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    [_tabBar insertTabWithImageDic:dict atIndex:index];
}

- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before change index, ask the delegate should change the index.
    
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) 
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
    // If target index if equal to current index, do nothing.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0) 
    {
        return;
    }
    NSLog(@"Display View.");
    _selectedIndex = index;
    
	UIViewController *selectedVC = [self.viewControllers objectAtIndex:index];
	
	selectedVC.view.frame = _transitionView.frame;
	if ([selectedVC.view isDescendantOfView:_transitionView]) 
	{
		[_transitionView bringSubviewToFront:selectedVC.view];
	}
	else
	{
		[_transitionView addSubview:selectedVC.view];
	}
    
//    // Notify the delegate, the viewcontroller has been changed.
//    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController::)]) 
//    {
//        [_delegate tabBarController:self didSelectViewController:selectedVC];
//    }
    

}

- (void) hideView:(int) idx yesOrNo:(BOOL)yesOrNo {

    UIViewController *selectedVC = [self.viewControllers objectAtIndex:idx];
    selectedVC.view.hidden = yesOrNo;
}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
    UINavigationController *nav = [self.viewControllers objectAtIndex:index];
    self.delegate = (id<LeveyTabBarControllerDelegate>)nav.viewControllers[0];
    
    [self.delegate tabBarController:self didSelectViewController:[self.viewControllers objectAtIndex:index]];
    
	if (self.selectedIndex == index) {
//        UINavigationController *nav = [self.viewControllers objectAtIndex:index];
        [nav popToRootViewControllerAnimated:YES];
    }else {
        [self displayViewAtIndex:index];
    }
}

- (void)hideshowTabbar:(BOOL)yesOrNO animated:(BOOL)animated {

    [self hideshowTabbar:yesOrNO animated:animated];
}

#pragma UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0) {
    

    [self hideView:1 yesOrNo:NO];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    self.selectedIndex = self.prevIdx;
    [self hidePopupView:YES animated:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
