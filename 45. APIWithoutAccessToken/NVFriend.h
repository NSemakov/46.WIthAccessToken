//
//  NVFriend.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVFriend : NSObject
@property (strong,nonatomic) NSString* firstName;
@property (strong,nonatomic) NSString* lastName;
@property (strong,nonatomic) NSString* userId;
@property (strong,nonatomic) NSURL* photo50;
@property (strong,nonatomic) NSURL* photo200;
@property (strong,nonatomic) NSString* country;
@property (strong,nonatomic) NSString* city;
@property (assign,nonatomic) BOOL isOnline;
@property (strong,nonatomic) NSString* education;
@property (strong,nonatomic) NSString* universities;
@property (strong,nonatomic) NSString* status;
@property (strong,nonatomic) NSString* last_seen;
@property (strong,nonatomic) NSString* interests;
@property (strong,nonatomic) NSString* music;
@property (strong,nonatomic) NSString* movies;
@property (strong,nonatomic) NSString* tv;
@property (strong,nonatomic) NSString* games;
@property (strong,nonatomic) NSString* about;
@property (strong,nonatomic) NSString* quotes;




@property (strong,nonatomic) NSArray* arrayOfNames;
@property (strong,nonatomic) NSArray* arrayOfObjects;
- (instancetype)initWithDictionary:(NSDictionary*) params;
@end
