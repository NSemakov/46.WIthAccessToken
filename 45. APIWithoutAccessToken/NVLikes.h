//
//  NVLikes.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVLikes : NSObject
@property (assign,nonatomic) NSInteger count;
@property (assign,nonatomic) NSInteger user_likes;
@property (assign,nonatomic) NSInteger can_like;
@property (assign,nonatomic) NSInteger can_publish;

- (instancetype)initWithDictionary:(NSDictionary*) params;
@end
