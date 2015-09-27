//
//  NVWallVC.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVUser.h"
#import "NVGroup.h"
#import "NVShowPhotoProtocol.h"
@class NVAttachmentCell;
@class NVRepostCell;


@interface NVWallVC : UIViewController <UITableViewDataSource, UITableViewDelegate,NVShowPhotoProtocol>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NVUser* person;
@property (strong,nonatomic) NVGroup* group;
@property (strong,nonatomic) NSMutableArray* arrayOfWallPosts;

@property (strong,nonatomic) NSMutableDictionary* attachmentCells;
@property (strong,nonatomic) NSMutableDictionary* repostCells;
@property (strong,nonatomic) NSMutableDictionary* textCells;
@property (strong,nonatomic) NSMutableDictionary* endCells;
@end
