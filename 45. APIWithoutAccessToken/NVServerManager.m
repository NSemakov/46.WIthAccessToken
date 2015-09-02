//
//  NVServerManager.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVServerManager.h"
#import "NVUser.h"
#import "NVWallPost.h"
#import "NVSubcription.h"
#import <AFNetworking/AFNetworking.h>
@implementation NVServerManager

+(NVServerManager*) sharedManager{
    static NVServerManager* manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[NVServerManager alloc]init];
    });
    return manager;
}


-(void) getFriendsFromServerCount:(NSInteger) count
                       withOffset:(NSInteger) offset
                        onSuccess:(void(^)(NSArray* friends)) onSuccess
                        onFailure:(void(^)(NSString* error)) onFailure{
    
    NSURL* baseURL=[NSURL URLWithString:@"https://api.vk.com/method"];
    AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    NSDictionary* dictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                              @(1814388),  @"user_id",
                              @"hints", @"order",
                              @(count),@"count",
                              @(offset),@"offset",
                              @"photo_50",@"fields",
                              @"nom",@"name_case",
                              @(5.37),@"v",
                              @"ru",@"lang",
                              nil];
    
    [manager GET:@"friends.get" parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"coming %@",responseObject);
        NSMutableArray* arrayOfFriends=[[NSMutableArray alloc]init];
        //NSLog(@"%@",[[responseObject objectForKey:@"response"] objectForKey:@"items"]);
        for (NSDictionary* obj in [[responseObject objectForKey:@"response"] objectForKey:@"items"]){
            NVUser* friend=[[NVUser alloc]initWithDictionary:obj];
            [arrayOfFriends addObject:friend];
        }
        if (onSuccess) {
            onSuccess(arrayOfFriends);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@ code %d",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %d",error,operation.error.code];
            onFailure(returnString);
        }
    }];

}

-(void) getFollowersFromServer:(NSInteger) userIds Count:(NSInteger) count
                       withOffset:(NSInteger) offset
                        onSuccess:(void(^)(NSArray* followers)) onSuccess
                        onFailure:(void(^)(NSString* error)) onFailure{
    
    NSURL* baseURL=[NSURL URLWithString:@"https://api.vk.com/method"];
    AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    NSDictionary* dictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                              @(userIds),  @"user_id",
                              @"hints", @"order",
                              @(count),@"count",
                              @(offset),@"offset",
                              @"photo_50",@"fields",
                              @"nom",@"name_case",
                              @(5.37),@"v",
                              @"ru",@"lang",
                              nil];
    
    [manager GET:@"users.getFollowers" parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"coming %@",responseObject);
        NSMutableArray* arrayOfFriends=[[NSMutableArray alloc]init];
        //NSLog(@"%@",[[responseObject objectForKey:@"response"] objectForKey:@"items"]);
        for (NSDictionary* obj in [[responseObject objectForKey:@"response"] objectForKey:@"items"]){
            NVUser* friend=[[NVUser alloc]initWithDictionary:obj];
            [arrayOfFriends addObject:friend];
        }
        if (onSuccess) {
            onSuccess(arrayOfFriends);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@ code %d",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %d",error,operation.error.code];
            onFailure(returnString);
        }
    }];
    
}
-(void) getSubscriptionsFromServer:(NSInteger) userIds Count:(NSInteger) count
                    withOffset:(NSInteger) offset
                     onSuccess:(void(^)(NSArray* subscriptions)) onSuccess
                     onFailure:(void(^)(NSString* error)) onFailure{
    
    NSURL* baseURL=[NSURL URLWithString:@"https://api.vk.com/method"];
    AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    NSDictionary* dictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                              @(userIds),  @"user_id",
                              @"hints", @"order",
                              @(count),@"count",
                              @(offset),@"offset",
                              @"photo_50",@"fields",
                              @"nom",@"name_case",
                              @(5.37),@"v",
                              @(1),@"extended",
                              @"ru",@"lang",
                              nil];
    
    [manager GET:@"users.getSubscriptions" parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"coming %@",responseObject);
        NSMutableArray* arrayOfSubscriptions=[[NSMutableArray alloc]init];
        //NSLog(@"%@",[[responseObject objectForKey:@"response"] objectForKey:@"items"]);
        for (NSDictionary* obj in [[responseObject objectForKey:@"response"] objectForKey:@"items"]){
            NVSubcription* sub=[[NVSubcription alloc]initWithDictionary:obj];
            [arrayOfSubscriptions addObject:sub];
        }
        if (onSuccess) {
            onSuccess(arrayOfSubscriptions);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@ code %d",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %d",error,operation.error.code];
            onFailure(returnString);
        }
    }];
    
}

-(void) getDetailOfFriendFromServer:(NSString*) userIds
                        onSuccess:(void(^)(NVUser* person)) onSuccess
                        onFailure:(void(^)(NSString* error)) onFailure{
    
    NSURL* baseURL=[NSURL URLWithString:@"https://api.vk.com/method"];
    AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    NSDictionary* dictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                              userIds,  @"user_ids",
                              @"bdate, city, country, photo_50, photo_200, online, education, universities, status, last_seen, counters, interests, music, movies, tv, games, about, quotes",@"fields",
                              @"nom",@"name_case",
                              @(5.37),@"v",
                              @"ru",@"lang",
                              nil];
    
    [manager GET:@"users.get" parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"coming %@",responseObject);
        NSDictionary* obj =[[responseObject objectForKey:@"response"] firstObject];
        //NSLog(@"coming2 %@",obj);
        NVUser* person=[[NVUser alloc]initWithDictionary:obj];
        if (onSuccess) {
            onSuccess(person);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@ code %d",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %d",error,operation.error.code];
            onFailure(returnString);
        }
    }];

}
-(void) getWallPostsOfFriendFromServer:(NSInteger) owner_id
                                 Count:(NSInteger) count
                            withOffset:(NSInteger) offset
                          onSuccess:(void(^)(NSArray* wallPosts)) onSuccess
                          onFailure:(void(^)(NSString* error)) onFailure{
    
    NSURL* baseURL=[NSURL URLWithString:@"https://api.vk.com/method"];
    AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    NSDictionary* dictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                              @(owner_id),  @"owner_id",
                              @(count),@"count",
                              @(offset),@"offset",
                              @(1),@"extended",
                              @(5.37),@"v",
                              @"ru",@"lang",
                              nil];
    
    [manager GET:@"wall.get" parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"coming %@",responseObject);
        NSArray* profiles=[[responseObject objectForKey:@"response"]objectForKey:@"profiles"];
        NSArray* groupes=[[responseObject objectForKey:@"response"]objectForKey:@"groupes"];
        NSMutableArray* arrayOfWallPosts=[[NSMutableArray alloc]init];
        for (NSDictionary* obj in [[responseObject objectForKey:@"response"] objectForKey:@"items"]){
            NVWallPost* sub=[[NVWallPost alloc]initWithDictionary:obj profiles:profiles andGroups:groupes];
            [arrayOfWallPosts addObject:sub];
        }
        if (onSuccess) {
            onSuccess(arrayOfWallPosts);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@ code %d",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %d",error,operation.error.code];
            onFailure(returnString);
        }
    }];
    
}
@end
