//
//  NVPhoto.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVPhoto : NSObject
@property (strong,nonatomic) NSNumber* idPhoto;
@property (strong,nonatomic) NSNumber* album_id;
@property (strong,nonatomic) NSNumber* owner_id;
@property (strong,nonatomic) NSNumber* user_id;
@property (strong,nonatomic) NSNumber* widthPhoto;
@property (strong,nonatomic) NSNumber* heightPhoto;
@property (strong,nonatomic) NSURL* photo_75;
@property (strong,nonatomic) NSURL* photo_130;
@property (strong,nonatomic) NSURL* photo_604;
@property (strong,nonatomic) NSURL* photo_2560;
@property (assign,nonatomic) BOOL isVertical;

- (instancetype)initWithDictionary:(NSDictionary*) params;
@end
