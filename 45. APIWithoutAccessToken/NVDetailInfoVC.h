//
//  NVDetailInfoVC.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NVUser;
@interface NVDetailInfoVC : UITableViewController
@property (strong,nonatomic) NVUser* person;
@property (strong,nonatomic) NSString* userIds;
@end
