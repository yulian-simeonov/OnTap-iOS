//
//  OTableViewController.h
//  Exclusive
//
//  Created by Jungrak Lee on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OViewController.h"

@interface OTableViewController : OViewController <UITableViewDelegate, UITableViewDataSource>
{

}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tableData;

@end
