//
//  ORefreshTableView.h
//  StyledFriend
//
//  Created by Jungrak Lee on 9/14/12.
//  Copyright (c) 2012 orfeostory, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ORefreshView.h"

@protocol ORefreshTableViewDelegate;

@interface ORefreshTableView : UITableView <ORefreshViewDelegate>
{
    id _refreshDelegate;
    
    ORefreshView *_refreshHeaderView;
    ORefreshView *_refreshFooterView;
    
    BOOL _refreshHeaderViewIsTriggered;
    BOOL _refreshFooterViewIsTriggered;
}

@property (nonatomic, assign) ORefreshView *refreshHeaderView;
@property (nonatomic, assign) ORefreshView *refreshFooterView;
@property (nonatomic, assign) IBOutlet id<ORefreshTableViewDelegate> refreshDelegate;

- (void)scrollViewWillBeginDragging;
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDragging;

- (void)finishTriggerRefreshView;

- (void)reloadLastUpdatedDate;

@end

@protocol ORefreshTableViewDelegate
@optional
- (BOOL)tableViewWillTriggerRefreshHeader:(ORefreshTableView *)tableView;
- (void)tableViewDidTriggerRefreshHeader:(ORefreshTableView *)tableView;
- (void)tableViewDidTriggerRefreshFooter:(ORefreshTableView *)tableView;
@end
