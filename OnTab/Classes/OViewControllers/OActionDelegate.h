//
//  OActionDelegate.h
//  StyledFriend
//
//  Created by Jungrak Lee on 8/22/12.
//  Copyright (c) 2012 orfeostory, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OActionDelegate <NSObject>
@optional
- (IBAction)pressedButton:(id)sender;
- (IBAction)changeSegment:(id)sender;
@end
