//
//  ORefreshView.h
//  StyledFriend
//
//  Created by Jungrak Lee on 9/14/12.
//  Copyright (c) 2012 orfeostory, inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	EGOOPullRefreshPulling = 0,
	EGOOPullRefreshNormal,
	EGOOPullRefreshLoading,	
} EGOPullRefreshState;

@protocol ORefreshViewDelegate;

@interface ORefreshView : UIView
{
	id _delegate;
	EGOPullRefreshState _state;

	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
	
    BOOL _reverse;
}

@property(nonatomic,assign) id <ORefreshViewDelegate> delegate;
@property(nonatomic,retain) UILabel *lastUpdatedLabel;
@property(nonatomic,retain) UILabel *statusLabel;
@property(nonatomic,assign) CALayer *arrowImage;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame reverse:(BOOL)reverse textColor:(UIColor *)textColor arrowImage:(UIImage *)image;
- (id)initWithFrame:(CGRect)frame arrowImage:(UIImage *)image textColor:(UIColor *)textColor;

- (void)reloadLastUpdatedDate;

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
@end

@protocol ORefreshViewDelegate
- (BOOL)ORefreshViewWillTriggerRefresh:(ORefreshView*)refreshView;
- (void)ORefreshViewDidTriggerRefresh:(ORefreshView*)refreshView;
- (BOOL)ORefreshViewDataSourceIsLoading:(ORefreshView*)refreshView;
@end
