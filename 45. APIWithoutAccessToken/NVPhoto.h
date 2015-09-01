//
//  NVPhoto.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVPhoto : NSObject
@property (assign,nonatomic) NSInteger idPhoto;
@property (assign,nonatomic) NSInteger album_id;
@property (assign,nonatomic) NSInteger owner_id;
@property (assign,nonatomic) NSInteger user_id;
@property (assign,nonatomic) NSUInteger widthPhoto;
@property (assign,nonatomic) NSUInteger heightPhoto;
@property (strong,nonatomic) NSURL* photo_75;
@property (strong,nonatomic) NSURL* photo_130;
@property (strong,nonatomic) NSURL* photo_604;
@property (strong,nonatomic) NSURL* photo_2560;
@property (assign,nonatomic) BOOL isVertical;

- (instancetype)initWithDictionary:(NSDictionary*) params;
@end
