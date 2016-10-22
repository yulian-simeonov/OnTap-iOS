//
//  SuccessViewController.m
//  OnTab
//
//  Created by ZhenLiu on 11/21/13.
//  Copyright (c) 2013 ZhenLiu. All rights reserved.
//

#import "SuccessViewController.h"

@interface SuccessViewController () {

    IBOutlet UIView*    vSuccess;
    IBOutlet UIView*    vFailed;
    IBOutlet UILabel*   lblPaid;
    IBOutlet UILabel*   lblEarned;
    IBOutlet UIScrollView*  scrlView;
    
}

@end

@implementation SuccessViewController

@synthesize isSuccess, dictDetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setLeftBarButtonImage:@"btn_back"];
        [self setRightBarButtonImage:@"btn_ontab"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.isSuccess) {
        self.title = @"SUCCESS!";
        [scrlView addSubview:vSuccess];
        scrlView.contentSize = CGSizeMake(320, vSuccess.frame.size.height+100);
    } else {
        self.title = @"FAILED!";
        [scrlView addSubview:vFailed];
        scrlView.contentSize = CGSizeMake(320, vFailed.frame.size.height+100);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark OActionDelegate Methods
- (void)pressedButton:(id)sender
{
    int tag = (int) [sender tag];
    switch (tag) {
        case kLeftBarButtonItem: {
        }   break;
        case kRightBarButtonItem:
            [APPDELEGATE didLogOut];
            break;
    }
}

@end
