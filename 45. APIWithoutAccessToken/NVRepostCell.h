//
//  NVRepostCell.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 03.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NVWallPost;
@class NVAttachmentCell;
@class NVWallVC;
@interface NVRepostCell : UITableViewCell <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) UITableView* tableView;
@property (assign,nonatomic) CGRect tableRect;
@property (assign,nonatomic) UITableView* parentTableView;
@property (strong,nonatomic) NVWallPost* wallPost;
@property (strong,nonatomic) NSMutableDictionary* attachmentCells;
@property (weak,nonatomic) NVWallVC* delegate;
- (instancetype)initWithWallPost:(NVWallPost*) wallPost andParentRect:(UITableView*) parentTableView;
@end
