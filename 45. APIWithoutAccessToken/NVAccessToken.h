//
//  NVAccessToken.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 15.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVAccessToken : NSObject
@property (strong,nonatomic) NSString* accessToken;
@property (strong,nonatomic) NSString* expiresIn;
@property (strong,nonatomic) NSString* userId;

@end
