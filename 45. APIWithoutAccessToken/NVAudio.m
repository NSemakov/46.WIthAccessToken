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
        self.idAudio=[params objectForKey:@"idAudio"];
        self.ownerId=[params objectForKey:@"ownerId"];
        self.artist=[params objectForKey:@"artist"];
        self.title=[params objectForKey:@"title"];
        self.duration=[params objectForKey:@"duration"];
        self.url=[params objectForKey:@"url"];

    }
    return self;
}
@end
