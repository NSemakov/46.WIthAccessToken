//
//  NVSubscriptionVC.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 29.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NVSubcription;
@class NVUser;
@class NVGroup;
@interface NVSubscriptionVC : UITableViewController
@property (strong,nonatomic) NSMutableArray* arrayOfSubscription;
@property (strong,nonatomic) NVSubcription* subscription;
@property (strong,nonatomic) NVUser* person;
//@property (strong,nonatomic) NVGroup* group;
@end
