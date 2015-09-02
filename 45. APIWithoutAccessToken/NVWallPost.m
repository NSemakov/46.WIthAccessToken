//
//  NVWall.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 29.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVWallPost.h"
#import "NVLikes.h"
@implementation NVWallPost
- (instancetype)initWithDictionary:(NSDictionary*) params profiles:(NSArray*)profiles andGroups:(NSArray*)groupes
{
    self = [super init];
    if (self) {
        //fullfill profiles
        
        self.profiles=[profiles mutableCopy];
        self.groups=[groupes mutableCopy];
        //NSLog(@"%@ ",self.profiles);
        self.author=[[NVUser alloc]initWithDictionary:[self.profiles firstObject]];
        //fullfill items
        
        //NSLog(@"%@ %@",self.author.firstName,self.author.lastName);
        if ([params objectForKey:@"copy_history"]) {
            //self.repost=[[NVWallPost alloc]initWithDictionary:[params objectForKey:@"copy_history"]] ;
        }
        self.from_id=(NSInteger)[params objectForKey:@"from_id"];
        self.owner_id=(NSInteger)[params objectForKey:@"owner_id"];

        double dateOfPost1=[[params objectForKey:@"date"] doubleValue];
        NSDate* dateOfPost2=[NSDate dateWithTimeIntervalSince1970:dateOfPost1];
        NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        self.dateOfPost=[NSString stringWithFormat:@"%@",[formatter stringFromDate:dateOfPost2]];
        
        
        self.text=[params objectForKey:@"text"];
        self.likes=[[NVLikes alloc]initWithDictionary:[params objectForKey:@"likes"]];
        self.repostsCount=(NSInteger)[[params objectForKey:@"reposts"] objectForKey:@"count"];
        self.commentsCount=(NSInteger)[[params objectForKey:@"comments"] objectForKey:@"count"];
        self.attachments=[params objectForKey:@"attachments"];


        [self fullfillArrayOfData];
       
    }
    return self;
}
- (void) fullfillArrayOfData {
    self.arrayOfData=[NSMutableArray new];
    self.arrayOfDataNames=[NSMutableArray new];
    if (self.author) {
        [self.arrayOfData addObject:self.author];
        [self.arrayOfDataNames addObject:@"author"];
    }
    if ([self.text length]) {//>0
        [self.arrayOfData addObject:self.text];
        [self.arrayOfDataNames addObject:@"text"];
    }
    if (self.attachments) {
        [self.arrayOfData addObject:self.attachments];
        [self.arrayOfDataNames addObject:@"attachments"];
    }
    
}
@end
