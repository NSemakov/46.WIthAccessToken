//
//  NVWall.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 29.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVWallPost.h"
#import "NVLikes.h"
#import "NVGroup.h"
#import "NVUser.h"
@implementation NVWallPost
- (instancetype)initWithDictionary:(NSDictionary*) params profiles:(NSArray*)profiles andGroups:(NSArray*)groupes
{
    self = [super init];
    if (self) {
        //fullfill profiles
        self.profiles=[profiles mutableCopy];
        self.groups=[groupes mutableCopy];
        self.from_id=[[params objectForKey:@"from_id"] integerValue];
        NSLog(@"groeps %@",groupes);
        
        //fullfill items
        
        if ([params objectForKey:@"copy_history"]) {
            self.repost=[[NVWallPost alloc]initWithDictionary:[[params objectForKey:@"copy_history"]firstObject] profiles:profiles andGroups:groupes];
        }
        
        self.owner_id=[[params objectForKey:@"owner_id"] integerValue];

        double dateOfPost1=[[params objectForKey:@"date"] doubleValue];
        NSDate* dateOfPost2=[NSDate dateWithTimeIntervalSince1970:dateOfPost1];
        NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        self.dateOfPost=[NSString stringWithFormat:@"%@",[formatter stringFromDate:dateOfPost2]];
        
        
        self.text=[params objectForKey:@"text"];
        self.likes=[[NVLikes alloc]initWithDictionary:[params objectForKey:@"likes"]];
        self.repostsCount=[[[params objectForKey:@"reposts"] objectForKey:@"count"] integerValue];
        self.commentsCount=[[[params objectForKey:@"comments"] objectForKey:@"count"] integerValue];
        self.attachments=[params objectForKey:@"attachments"];

        [self findAuthor:profiles groups:groupes];
        [self fullfillArrayOfData];
        
       
    }
    return self;
}
- (void) fullfillArrayOfData {
    self.arrayOfData=[NSMutableArray new];
    self.arrayOfDataNames=[NSMutableArray new];
    if (self.authorUser) {
        [self.arrayOfData addObject:self.authorUser];
        [self.arrayOfDataNames addObject:@"author"];
    } else if (self.authorGroup) {
        [self.arrayOfData addObject:self.authorGroup];
        [self.arrayOfDataNames addObject:@"author"];
    }
    
    if ([self.text length]) {//>0
        [self.arrayOfData addObject:self.text];
        [self.arrayOfDataNames addObject:@"text"];
    }
    if (self.repost) {
        [self.arrayOfData addObject:self.repost];
        [self.arrayOfDataNames addObject:@"repost"];
    }
    if (self.attachments) {
        [self.arrayOfData addObject:self.attachments];
        [self.arrayOfDataNames addObject:@"attachments"];
    }
    
}
- (void) findAuthor:(NSArray*)profiles groups:(NSArray*) groups {
    for (NSDictionary* obj in profiles) {
        //NSLog(@"from %@, owner %@",[obj objectForKey:@"from_id"],[obj objectForKey:@"owner_id"]);
        if ([[obj objectForKey:@"id"]integerValue] == self.from_id) {
            
            self.authorUser=[[NVUser alloc]initWithDictionary:obj];
        }
    }
    if (!self.authorUser) {
        for (NSDictionary* obj in groups) {
            //NSLog(@"from %@, owner %@",[obj objectForKey:@"from_id"],[obj objectForKey:@"owner_id"]);
            if ([[obj objectForKey:@"id"]integerValue] == -self.from_id) {
                //NSLog(@"%ld",self.from_id);
                self.authorGroup=[[NVGroup alloc]initWithDictionary:obj];
            }
        }
        
    }

}
@end
