//
//  NVAttachmentCell.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVAttachmentCell : UITableViewCell
@property (strong,nonatomic) NSMutableArray* photos;
@property (strong,nonatomic) NSMutableArray* audios;
@property (strong,nonatomic) NSMutableArray* docs;

@property (assign,nonatomic) CGRect lastFrame;
@property (assign,nonatomic) CGRect parentTableViewRect;
- (instancetype)initWithAttachments:(NSArray*) att andParentRect:(CGRect) parentRect;
@end
