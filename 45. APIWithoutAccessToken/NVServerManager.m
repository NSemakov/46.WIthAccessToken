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
#import "NVAccessToken.h"
#import "NVLoginVC.h"
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
                              self.currentUser.userId,  @"user_id",
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
        NSLog(@"error %@ code %ld",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %ld",error,operation.error.code];
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
        NSLog(@"error %@ code %ld",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %ld",error,operation.error.code];
            onFailure(returnString);
        }
    }];
    
}
-(void) getSubscriptionsFromServer:(NSString*) userIds Count:(NSInteger) count
                    withOffset:(NSInteger) offset
                     onSuccess:(void(^)(NSArray* subscriptions)) onSuccess
                     onFailure:(void(^)(NSString* error)) onFailure{
    
    NSURL* baseURL=[NSURL URLWithString:@"https://api.vk.com/method"];
    AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    NSDictionary* dictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                              userIds,  @"user_id",
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
        NSLog(@"error %@ code %ld",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %ld",error,operation.error.code];
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
        NSLog(@"error %@ code %ld",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %ld",error,operation.error.code];
            onFailure(returnString);
        }
    }];

}
-(void) getWallPostsOfFriendFromServer:(NSString*) owner_id
                                 Count:(NSInteger) count
                            withOffset:(NSInteger) offset
                          onSuccess:(void(^)(NSArray* wallPosts)) onSuccess
                          onFailure:(void(^)(NSString* error)) onFailure{
    
    NSURL* baseURL=[NSURL URLWithString:@"https://api.vk.com/method"];
    AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    NSDictionary* dictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                              owner_id,  @"owner_id",
                              @(count),@"count",
                              @(offset),@"offset",
                              @(1),@"extended",
                              @(5.37),@"v",
                              @"ru",@"lang",
                              nil];
    
    [manager GET:@"wall.get" parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"coming %@",responseObject);
        NSArray* profiles=[[responseObject objectForKey:@"response"]objectForKey:@"profiles"];
        NSArray* groupes=[[responseObject objectForKey:@"response"]objectForKey:@"groups"];
        NSMutableArray* arrayOfWallPosts=[[NSMutableArray alloc]init];
        for (NSDictionary* obj in [[responseObject objectForKey:@"response"] objectForKey:@"items"]){
            NVWallPost* sub=[[NVWallPost alloc]initWithDictionary:obj profiles:profiles andGroups:groupes];
            [arrayOfWallPosts addObject:sub];
        }
        if (onSuccess) {
            onSuccess(arrayOfWallPosts);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@ code %ld",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %ld",error,operation.error.code];
            onFailure(returnString);
        }
    }];
    
}
-(void) getUserFromServer:(NSString*) userId
                             onSuccess:(void(^)(NVUser * user)) onSuccess
                             onFailure:(void(^)(NSString* error)) onFailure{
    
    NSURL* baseURL=[NSURL URLWithString:@"https://api.vk.com/method"];
    AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    NSDictionary* dictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                              userId,  @"user_ids",
                              @(5.37),@"v",
                              @"ru",@"lang",
                              nil];
    
    [manager GET:@"users.get" parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"coming %@",responseObject);
        
        for (NSDictionary* obj in [responseObject objectForKey:@"response"] ){
            NVUser* currentUser=[[NVUser alloc]initWithDictionary:obj];
            self.currentUser=currentUser;
           if (onSuccess) {
               onSuccess(currentUser);
           }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@ code %ld",error,operation.error.code);
        if (onFailure) {
            NSString* returnString=[NSString stringWithFormat:@"error %@ code %ld",error,operation.error.code];
            onFailure(returnString);
        }
    }];
    
}
- (void) authorizeUser:(void(^)(NVUser* user))completion  {
    UIStoryboard* storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NVLoginVC* loginVC=[storyboard instantiateViewControllerWithIdentifier:@"NVLoginVC"];
    
    loginVC.completionBlock=^(NVAccessToken* token){
        self.accessToken=token;
        
        if (token) {
            [self getUserFromServer:token.userId onSuccess:^(NVUser *user) {
                
                if (completion) {
                   completion(user);
                }
                
            } onFailure:^(NSString *error) {
                completion(nil);
            }];
        } else {
            completion(nil);
        }
    };
    [[[[[UIApplication sharedApplication]windows]firstObject]rootViewController] presentViewController:loginVC animated:YES completion:nil];
    
    
}

- (void)postWallCreateCommentText:(NSString*)text
                            image:(NSArray *)image
                      onGroupWall:(NSString*)groupID
                        onSuccess:(void(^)(id result))success
                        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSString *idGroup = [NSString stringWithFormat:@"%@",groupID];
    
//    if (![idGroup hasPrefix:@"-"]) {
//        idGroup = [@"-" stringByAppendingString:idGroup];
//    }
    NSURL* baseURL=[NSURL URLWithString:@"https://api.vk.com/method"];
        AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    if ([image count]>0) {
        
        
        NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                         groupID,@"user_id",@"5.37",@"v",self.accessToken.accessToken,@"access_token", nil];
        
        
        
        [manager GET:@"photos.getWallUploadServer" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON photos.getWallUploadServer: %@", responseObject);
            
            NSDictionary *objects = [responseObject objectForKey:@"response"];
            
            NSString *upload_url = [objects objectForKey:@"upload_url"];
            NSString *user_id = [objects objectForKey:@"user_id"];
            
            AFHTTPRequestOperationManager *manager2= [AFHTTPRequestOperationManager manager];
            manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            [manager2 POST:upload_url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                for (int i = 0; i < [image count]; i++) {
                    UIImage *img = [image objectAtIndex:i];
                    NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
                    [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file%d",i] fileName:[NSString stringWithFormat:@"file%d.png",i] mimeType:@"image/jpeg"];
                }
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"Success POST:upload: %@", responseObject);
                
                NSString *hash =[responseObject objectForKey:@"hash"] ;
                NSString *photo = [responseObject objectForKey:@"photo"] ;
                NSString *server = [responseObject objectForKey:@"server"];
                
                
                NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:user_id,@"user_id",
               /*user_id,@"group_id",*/
                                       server,@"server",photo,@"photo",hash,@"hash",@"5.37",@"v",self.accessToken.accessToken,@"access_token", nil];
                
                [manager GET:@"photos.saveWallPhoto" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSLog(@"photos.saveWallPhoto: %@", responseObject);
                    
                    NSArray *objects = [responseObject objectForKey:@"response"];
                    
                    NSMutableString *attachments = [NSMutableString string];
                    
                    for (NSDictionary *dict in objects) {
                        
                        NSString *owner_id = [dict objectForKey:@"owner_id"];
                        NSString *media_id = [dict objectForKey:@"id"];
                        
                        [attachments appendString:[NSString stringWithFormat:@"photo%@_%@,",owner_id,media_id]];
                        
                    }
                    
                    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:idGroup,@"owner_id",text,@"message",attachments,@"attachments",self.accessToken.accessToken, @"access_token", nil];
                    
                    [manager POST:@"wall.post" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
                        
                        NSLog(@"JSON: %@", responseObject);
                        
                        if (success) {
                            success(responseObject);
                        }
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                        if (failure) {
                            failure(error, operation.response.statusCode);
                        }
                    }];
                    
                    
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        
        
    } else {
        
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:idGroup,@"owner_id",text,@"message",self.accessToken.accessToken, @"access_token", nil];
        
        [manager POST:@"wall.post" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
            
            NSLog(@"JSON: %@", responseObject);
            
            if (success) {
                success(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failure) {
                failure(error, operation.response.statusCode);
            }
        }];
    }
    
}
@end
