//
//  NVFollowersVC.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 29.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NVFriend;
@interface NVFollowersVC : UITableViewController
@property (strong,nonatomic) NSMutableArray* arrayOfFollowers;
@property (strong,nonatomic) NVFriend* person;
@end