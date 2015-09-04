//
//  NVAudio.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVAudio.h"

@implementation NVAudio
- (instancetype)initWithDictionary:(NSDictionary*) params
{
    self = [super init];
    if (self) {
        self.idAudio=[[params objectForKey:@"id"] integerValue];
        self.ownerId=[[params objectForKey:@"owner_id"] integerValue];
        self.artist=[params objectForKey:@"artist"];
        self.title=[params objectForKey:@"title"];
        self.duration=[[params objectForKey:@"duration"] integerValue];
        self.url=[NSURL URLWithString:[params objectForKey:@"url"]];
        
    }
    return self;
}
@end
