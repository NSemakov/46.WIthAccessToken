//
//  NVLikes.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVLikes.h"

@implementation NVLikes

- (instancetype)initWithDictionary:(NSDictionary*) params
{
    self = [super init];
    if (self) {
        self.count=[[params objectForKey:@"count"] integerValue];
        self.user_likes=[[params objectForKey:@"user_likes"] integerValue];
        self.can_like=[[params objectForKey:@"can_like"] integerValue];
        self.can_publish=[[params objectForKey:@"can_publish"] integerValue];
    }
    return self;
}
@end
