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
        self.idAudio=(NSInteger)[params objectForKey:@"idAudio"];
        self.ownerId=(NSInteger)[params objectForKey:@"ownerId"];
        self.artist=[params objectForKey:@"artist"];
        self.title=[params objectForKey:@"title"];
        self.duration=(NSInteger)[params objectForKey:@"duration"];
        self.url=[NSURL URLWithString:[params objectForKey:@"url"]];

    }
    return self;
}
@end
