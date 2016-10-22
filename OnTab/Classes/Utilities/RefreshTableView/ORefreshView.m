//
//  ORefreshView.m
//  StyledFriend
//
//  Created by Jungrak Lee on 9/14/12.
//  Copyright (c) 2012 orfeostory, inc. All rights reserved.
//

#import "ORefreshView.h"

#define FLIP_ANIMATION_DURATION 0.18f


@interface ORefreshView (Private)
- (void)setState:(EGOPullRefreshState)state;
@end

@implementation ORefreshView

@synthesize delegate = _delegate;
@synthesize lastUpdatedLabel = _lastUpdatedLabel;
@synthesize statusLabel = _statusLabel;
@synthesize arrowImage = _arrowImage;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame reverse:NO textColor:[UIColor whiteColor] arrowImage:[UIImage imageNamed:@"blueArrow.png"]];
}

- (id)initWithFrame:(CGRect)frame reverse:(BOOL)reverse textColor:(UIColor *)textColor arrowImage:(UIImage *)image
{
    _reverse = reverse;
    
    return [self initWithFrame:frame arrowImage:image textColor:textColor];
}

- (id)initWithFrame:(CGRect)frame arrowImage:(UIImage *)image textColor:(UIColor *)textColor  {
    if((self = [super initWithFrame:frame])) {
		
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor clearColor];
        
		_lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, _reverse ? 35.0f : frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		_lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
		_lastUpdatedLabel.textColor = textColor;
		_lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		_lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		_lastUpdatedLabel.backgroundColor = [UIColor blackColor];
		[_lastUpdatedLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:_lastUpdatedLabel];
		
		_statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, _reverse ? 17.0f : frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		_statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		_statusLabel.textColor = textColor;
		_statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		_statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		_statusLabel.backgroundColor = [UIColor blackColor];
		[_statusLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:_statusLabel];
		
		self.arrowImage = [CALayer layer];
		self.arrowImage.frame = CGRectMake(31.0f, _reverse ? 27.0f : frame.size.height - 38.0f, 18.0f, 30.0f);
		self.arrowImage.contentsGravity = kCAGravityResizeAspect;
		self.arrowImage.contents = (id)image.CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			self.arrowImage.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:self.arrowImage];
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		view.frame = CGRectMake(25.0f, _reverse ? 27.0f : frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		[view release];
		
		
		[self setState:EGOOPullRefreshNormal];
		
    }
	
    return self;
}

#pragma mark -
#pragma mark Setters

- (void)reloadLastUpdatedDate
{
    NSDate *date = [NSDate date];
    
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    
    _lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:date]];
    
    [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setState:(EGOPullRefreshState)state
{
	switch (state) {
		case EGOOPullRefreshPulling:
			
			_statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh status");
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            
            if (_reverse == YES) {
                _arrowImage.transform = CATransform3DIdentity;
            } else {
                _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            }
            
			[CATransaction commit];
			
			break;
		case EGOOPullRefreshNormal:
			
			if (_state == EGOOPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                
                if (_reverse == YES) {
                    _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
                } else {
                    _arrowImage.transform = CATransform3DIdentity;
                }
                
                [CATransaction commit];
			}
			
			_statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh status");
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = NO;
            
            if (_reverse == YES) {
                _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            } else {
                _arrowImage.transform = CATransform3DIdentity;
            }
            
			[CATransaction commit];
			
			[self reloadLastUpdatedDate];
			
			break;
		case EGOOPullRefreshLoading:
			
			_statusLabel.text = NSLocalizedString(@"Loading...", @"Loading Status");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = state;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (_state == EGOOPullRefreshLoading) {
        if (_reverse == YES) {
            CGFloat offset = MAX(scrollView.contentOffset.y + self.bounds.size.height - scrollView.contentSize.height, 0);
            offset = MIN(offset, 60);
            
            scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, offset, 0.0f);
        } else {
            CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
            offset = MIN(offset, 60);
            
            scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
        }
	} else if (scrollView.isDragging) {
		BOOL loading = NO;
		if ([_delegate respondsToSelector:@selector(ORefreshViewDataSourceIsLoading:)]) {
			loading = [_delegate ORefreshViewDataSourceIsLoading:self];
		}
		
        if (_reverse == YES) {
            if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y + self.bounds.size.height < scrollView.contentSize.height + 65.0f && scrollView.contentOffset.y + self.bounds.size.height > scrollView.contentSize.height && !loading) {
                [self setState:EGOOPullRefreshNormal];
            } else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y + self.bounds.size.height > scrollView.contentSize.height + 65.0f && !loading) {
                [self setState:EGOOPullRefreshPulling];
            }
        } else {
            if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !loading) {
                [self setState:EGOOPullRefreshNormal];
            } else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !loading) {
                [self setState:EGOOPullRefreshPulling];
            }
		}
		
        if (_reverse == YES) {
            if (scrollView.contentInset.bottom != 0) {
                scrollView.contentInset = UIEdgeInsetsZero;
            }
        } else {
            if (scrollView.contentInset.top != 0) {
                scrollView.contentInset = UIEdgeInsetsZero;
            }
        }
	}
    
    [[[self superview] superview] setNeedsDisplay];
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if ([_delegate respondsToSelector:@selector(ORefreshViewWillTriggerRefresh:)]) {
        if ([_delegate ORefreshViewWillTriggerRefresh:self] == NO) {
            return;
        }
    }
    
	BOOL loading = NO;
    
	if ([_delegate respondsToSelector:@selector(ORefreshViewDataSourceIsLoading:)]) {
		loading = [_delegate ORefreshViewDataSourceIsLoading:self];
	}
    
    if (_reverse == YES) {
        if (scrollView.contentOffset.y + self.bounds.size.height >= scrollView.contentSize.height + 65.0f && !loading) {
            if ([_delegate respondsToSelector:@selector(ORefreshViewDidTriggerRefresh:)]) {
                [self setState:EGOOPullRefreshLoading];
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.2];
                scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 60.0f, 0.0f);
                [UIView commitAnimations];
                
                [_delegate ORefreshViewDidTriggerRefresh:self];
            }
        }
    } else {
        if (scrollView.contentOffset.y <= - 65.0f && !loading) {
            if ([_delegate respondsToSelector:@selector(ORefreshViewDidTriggerRefresh:)]) {
                [self setState:EGOOPullRefreshLoading];
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.2];
                scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
                [UIView commitAnimations];
                
                [_delegate ORefreshViewDidTriggerRefresh:self];
            }
        }
    }
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:EGOOPullRefreshNormal];
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	_delegate = nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
    
    [super dealloc];
}

@end
