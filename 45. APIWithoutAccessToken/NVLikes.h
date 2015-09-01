//
//  NVLikes.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVLikes : NSObject
@property (strong,nonatomic) NSNumber* count;
@property (strong,nonatomic) NSNumber* user_likes;
@property (strong,nonatomic) NSNumber* can_like;
@property (strong,nonatomic) NSNumber* can_publish;

- (instancetype)initWithDictionary:(NSDictionary*) params;
@end
