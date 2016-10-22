//
//  ORefreshTableView.m
//  StyledFriend
//
//  Created by Jungrak Lee on 9/14/12.
//  Copyright (c) 2012 orfeostory, inc. All rights reserved.
//

#import "ORefreshTableView.h"

@implementation ORefreshTableView

@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize refreshFooterView = _refreshFooterView;
@synthesize refreshDelegate = _refreshDelegate;

- (void)setRefreshHeaderView:(ORefreshView *)refreshHeaderView
{
    if (refreshHeaderView == nil) {
        [_refreshHeaderView removeFromSuperview];
    }
    
    _refreshHeaderView = refreshHeaderView;
}

- (void)setRefreshFooterView:(ORefreshView *)refreshFooterView
{
    if (refreshFooterView == nil) {
        [_refreshFooterView removeFromSuperview];
    }
    
    _refreshFooterView = refreshFooterView;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (CGRectIsEmpty(frame) == YES) {
        return;
    }
    
    _refreshHeaderView = [[[ORefreshView alloc] initWithFrame:CGRectMake(0.0f, -frame.size.height, frame.size.width, frame.size.height)] autorelease];
    _refreshHeaderView.delegate = self;
    
    [self addSubview:_refreshHeaderView];
    
    _refreshFooterView = [[[ORefreshView alloc] initWithFrame:CGRectMake(0.0f, -frame.size.height, frame.size.width, frame.size.height) reverse:YES textColor:[UIColor whiteColor] arrowImage:nil] autorelease];
    _refreshFooterView.delegate = self;
    
    [self addSubview:_refreshFooterView];
}

- (void)scrollViewWillBeginDragging
{
    if (self.contentSize.height <= self.bounds.size.height) {
        return;
    }
    
    CGRect frame = _refreshFooterView.frame;
    frame.origin.y = self.contentSize.height;
    
    _refreshFooterView.frame = frame;
}

- (void)scrollViewDidScroll
{
    if (self.contentOffset.y < 0) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:self];
    } else if (self.contentOffset.y + self.bounds.size.height > self.contentSize.height) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDragging
{
    if (self.contentOffset.y < 0) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self];
    } else if (self.bounds.size.height > self.contentSize.height - self.contentOffset.y) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:self];
    }
}

- (void)finishTriggerRefreshView
{
    if (_refreshHeaderViewIsTriggered == YES) {
        _refreshHeaderViewIsTriggered = NO;
        
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    }
    
    if (_refreshFooterViewIsTriggered == YES) {
        _refreshFooterViewIsTriggered = NO;
        
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    }
}

- (void)reloadLastUpdatedDate
{
    [_refreshHeaderView reloadLastUpdatedDate];
    [_refreshFooterView reloadLastUpdatedDate];
}

#pragma mark -
#pragma mark ORefreshViewDelegate Methods
- (BOOL)ORefreshViewWillTriggerRefresh:(ORefreshView*)refreshView
{
    if ([_refreshDelegate respondsToSelector:@selector(tableViewWillTriggerRefreshHeader:)] == YES) {
        if ([_refreshDelegate tableViewWillTriggerRefreshHeader:self] == NO) {
            return NO;
        }
    }
    
    return YES;
}

- (void)ORefreshViewDidTriggerRefresh:(ORefreshView*)refreshView
{
    if (refreshView == _refreshHeaderView) {
        if ([_refreshDelegate respondsToSelector:@selector(tableViewDidTriggerRefreshHeader:)] == YES) {
            [_refreshDelegate tableViewDidTriggerRefreshHeader:self];
            
            _refreshHeaderViewIsTriggered = YES;
        }
    } else /*if (refreshView == _refreshFooterView)*/ {
        if ([_refreshDelegate respondsToSelector:@selector(tableViewDidTriggerRefreshFooter:)] == YES) {
            [_refreshDelegate tableViewDidTriggerRefreshFooter:self];
            
            _refreshFooterViewIsTriggered = YES;
        }
    }
}

- (BOOL)ORefreshViewDataSourceIsLoading:(ORefreshView*)refreshView
{
    if (refreshView == _refreshHeaderView) {
        return _refreshHeaderViewIsTriggered;
    }
    
	return _refreshFooterViewIsTriggered;
}

@end
