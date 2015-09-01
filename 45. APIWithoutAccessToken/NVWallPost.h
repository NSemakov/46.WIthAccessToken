//
//  NVWall.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 29.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVUser.h"
@class NVLikes;
@interface NVWallPost : NSObject

@property (strong,nonatomic) NVUser* author;
@property (strong,nonatomic) NVWallPost* repost;


@property (assign,nonatomic) NSInteger from_id;
@property (assign,nonatomic) NSInteger owner_id;
@property (strong,nonatomic) NSString* dateOfPost;
@property (strong,nonatomic) NSString* text;


@property (strong,nonatomic) NSArray* attachments;
@property (strong,nonatomic) NSDictionary* comments;
@property (strong,nonatomic) NVLikes* likes;
@property (assign,nonatomic) NSInteger repostsCount;
@property (assign,nonatomic) NSInteger commentsCount;
@property (strong,nonatomic) NSMutableArray* profiles;
@property (strong,nonatomic) NSMutableArray* groups;

@property (strong,nonatomic) NSMutableArray* arrayOfData;
@property (strong,nonatomic) NSMutableArray* arrayOfDataNames;
- (instancetype)initWithDictionary:(NSDictionary*) params profiles:(NSArray*)profiles andGroups:(NSArray*)groupes;
@end
