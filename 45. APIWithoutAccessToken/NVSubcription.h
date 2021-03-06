//
//  NVSubcription.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 29.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NVGroup;
@class NVUser;
@interface NVSubcription : NSObject
@property (strong,nonatomic) NVUser* person;
@property (strong,nonatomic) NVGroup* group;
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSURL* photo50;
- (instancetype)initWithDictionary:(NSDictionary*) params;
@end
