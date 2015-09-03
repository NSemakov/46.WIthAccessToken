//
//  NVGroup.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 04.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVGroup : NSObject
@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) NSInteger idGroup;
@property (assign,nonatomic) NSInteger isClosed;
@property (strong,nonatomic) NSString* screen_name;
@property (strong,nonatomic) NSString* typeOfGroup;//i.e. page etc
@property (strong,nonatomic) NSURL* photo_50;
@property (strong,nonatomic) NSURL* photo_100;
@property (strong,nonatomic) NSURL* photo_200;

- (instancetype)initWithDictionary:(NSDictionary*) params;
@end
