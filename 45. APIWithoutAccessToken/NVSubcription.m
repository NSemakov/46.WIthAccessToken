//
//  NVSubcription.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 29.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVSubcription.h"
#import "NVUser.h"
#import "NVGroup.h"
@implementation NVSubcription
- (instancetype)initWithDictionary:(NSDictionary*) params
{
    self = [super init];
    if (self) {
        self.name=[params objectForKey:@"name"];
        self.photo50=[NSURL URLWithString:[params objectForKey:@"photo_50"]];
        if ([params objectForKey:@"first_name"]) {
            self.person=[[NVUser alloc]initWithDictionary:params];
        } else {
            self.group=[[NVGroup alloc]initWithDictionary:params];
        }
    }
    return self;
    
}
@end
