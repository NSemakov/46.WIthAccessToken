//
//  NVDetailInfoVC.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NVFriend;
@interface NVDetailInfoVC : UITableViewController
@property (strong,nonatomic) NVFriend* person;
@property (strong,nonatomic) NSString* userIds;
@end
