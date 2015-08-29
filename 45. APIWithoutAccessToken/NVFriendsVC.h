//
//  ViewController.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVFriendsVC : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray* arrayOfFriends;

@end

