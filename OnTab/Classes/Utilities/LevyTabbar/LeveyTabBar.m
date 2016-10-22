//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import "LeveyTabBar.h"
#import "LeveyTabBarController.h"
#import "PopupView.h"
#import "CustomTags.h"

#define kTabItemYPos    0//43.0f

@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;
@synthesize vcTabbarCtrl = _vcTabbarCtrl;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor redColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];

		for (int i = 0; i < [imageArray count]; i++)
        {
            NSArray *arrWid = [NSArray arrayWithObjects:@"80", @"80", @"80", @"80", nil];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.showsTouchWhenHighlighted = YES;

            float x = 0;
            for (int j=0; j<i; j++) {
                x += [[arrWid objectAtIndex:j] floatValue];
            }
            btn.frame = CGRectMake(x, kTabItemYPos, [[arrWid objectAtIndex:i] floatValue]+2, frame.size.height-kTabItemYPos);
            NSLog(@"%f", x);
            
			btn.showsTouchWhenHighlighted = YES;
			btn.tag = i;
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self.buttons addObject:btn];
			[self addSubview:btn];
            
            NSLog(@"%@", NSStringFromCGRect(self.frame));
		}
        
    }
    return self;
}
- (void) tabBtnCtrlClicked:(id) sender {

    NSLog(@"Control Tab button Clicked!");
    [_vcTabbarCtrl hidesTabBar:!_vcTabbarCtrl.tabBarHidden animated:YES];
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
	[self selectTabAtIndex:btn.tag];
//    NSLog(@"Select index: %d",btn.tag);
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < [self.buttons count]; i++)
	{
		UIButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
		b.userInteractionEnabled = YES;
	}
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
//	btn.userInteractionEnabled = NO;
}



- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
   
    // Re-index the buttons
     CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons) 
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
    
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    
//    CGFloat width = 320.0f / ([self.buttons count] + 1);
//    for (UIButton *b in self.buttons)
//    {
//        if (b.tag >= index)
//        {
//            b.tag ++;
//        }
//        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
//    }
    
    
    NSArray *arrWid = [NSArray arrayWithObjects:@"80", @"80", @"80", @"80", nil];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    float x = 0;
    for (int i=0; i<index; i++) {
        x += [[arrWid objectAtIndex:index] floatValue];
    }
    btn.frame = CGRectMake(x, 0, [[arrWid objectAtIndex:index] floatValue]+1, self.frame.size.height);
    NSLog(@"%f", x);
    
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Seleted"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}

- (void)dealloc
{
    [_backgroundView release];
    [_buttons release];
    [super dealloc];
}

@end
