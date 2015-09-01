//
//  NVServerManager.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NVUser;
@interface NVServerManager : NSObject
+(NVServerManager*) sharedManager;
-(void) getFriendsFromServerCount:(NSInteger) count
                       withOffset:(NSInteger) offset
                        onSuccess:(void(^)(NSArray* friends)) onSuccess
                        onFailure:(void(^)(NSString* error)) onFailure;
-(void) getDetailOfFriendFromServer:(NSString*) userIds
                               onSuccess:(void(^)(NVUser* person)) onSuccess
                               onFailure:(void(^)(NSString* error)) onFailure;
-(void) getFollowersFromServer:(NSInteger) userIds Count:(NSInteger) count
                    withOffset:(NSInteger) offset
                     onSuccess:(void(^)(NSArray* followers)) onSuccess
                     onFailure:(void(^)(NSString* error)) onFailure;
-(void) getSubscriptionsFromServer:(NSInteger) userIds Count:(NSInteger) count
                        withOffset:(NSInteger) offset
                         onSuccess:(void(^)(NSArray* subscriptions)) onSuccess
                         onFailure:(void(^)(NSString* error)) onFailure;
-(void) getWallPostsOfFriendFromServer:(NSInteger) owner_id
                                 Count:(NSInteger) count
                            withOffset:(NSInteger) offset
                             onSuccess:(void(^)(NSArray* wallPosts)) onSuccess
                             onFailure:(void(^)(NSString* error)) onFailure;
@end
