//
//  NVGroup.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 04.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVGroup.h"

@implementation NVGroup
- (instancetype)initWithDictionary:(NSDictionary*) params
{
    self = [super init];
    if (self) {
        self.name=[params objectForKey:@"name"];
        self.idGroup=[[params objectForKey:@"id"] integerValue];
        self.isClosed=[[params objectForKey:@"isClosed"] integerValue];
        self.screen_name=[params objectForKey:@"screen_name"];
        self.typeOfGroup=[params objectForKey:@"type"];
        self.photo_50=[NSURL URLWithString:[params objectForKey:@"photo_50"]];
        self.photo_100=[NSURL URLWithString:[params objectForKey:@"photo_100"]];
        self.photo_200=[NSURL URLWithString:[params objectForKey:@"photo_200"]];
    }
    return self;
    
}

@end
