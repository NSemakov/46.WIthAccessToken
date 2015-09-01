//
//  NVWallVC.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVUser.h"
@interface NVWallVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NVUser* person;
@property (strong,nonatomic) NSMutableArray* arrayOfWallPosts;
@end
