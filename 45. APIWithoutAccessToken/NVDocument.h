//
//  NVDocument.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 04.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVDocument : NSObject
@property (assign,nonatomic) NSInteger idDoc;
@property (assign,nonatomic) NSInteger owner_id;
@property (assign,nonatomic) NSString* title;
@property (assign,nonatomic) NSInteger size; //bytes
@property (assign,nonatomic) NSString* extension;
@property (strong,nonatomic) NSURL* urlDoc;
@property (strong,nonatomic) NSURL* photo_100; //100*75

- (instancetype)initWithDictionary:(NSDictionary*) params;
@end
