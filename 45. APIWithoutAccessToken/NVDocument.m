//
//  NVDocument.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 04.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVDocument.h"

@implementation NVDocument
- (instancetype)initWithDictionary:(NSDictionary*) params
{
    self = [super init];
    if (self) {
        
        self.idDoc=[[params objectForKey:@"id"]integerValue];
        self.owner_id=[[params objectForKey:@"owner_id"] integerValue];
        self.title=[params objectForKey:@"title"];
        self.size=[[params objectForKey:@"width"] integerValue];
        self.extension=[params objectForKey:@"extension"] ;
        
        self.urlDoc=[NSURL URLWithString:[params objectForKey:@"url"]];
        self.photo_100=[NSURL URLWithString:[params objectForKey:@"photo_100"]];

    }
    return self;
}
@end
