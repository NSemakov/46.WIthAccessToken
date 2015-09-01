//
//  NVAudio.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVAudio : NSObject
@property (assign,nonatomic) NSInteger idAudio;
@property (assign,nonatomic) NSInteger ownerId;
@property (strong,nonatomic) NSString* artist;
@property (strong,nonatomic) NSString* title;
@property (assign,nonatomic) NSInteger duration;
@property (strong,nonatomic) NSURL* url;

- (instancetype)initWithDictionary:(NSDictionary*) params;
@end
