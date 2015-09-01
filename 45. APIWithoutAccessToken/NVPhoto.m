//
//  NVPhoto.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVPhoto.h"
#import <UIKit/UIKit.h>
@implementation NVPhoto

- (instancetype)initWithDictionary:(NSDictionary*) params;
{
    self = [super init];
    if (self) {
        self.idPhoto=[params objectForKey:@"idPhoto"];
        self.album_id=[params objectForKey:@"album_id"];
        self.owner_id=[params objectForKey:@"owner_id"];
        self.user_id=[params objectForKey:@"user_id"];
        self.widthPhoto=[params objectForKey:@"widthPhoto"];
        self.heightPhoto=[params objectForKey:@"heightPhoto"];
        self.photo_75=[params objectForKey:@"photo_75"];
        self.photo_130=[params objectForKey:@"photo_130"];
        self.photo_130=[params objectForKey:@"photo_604"];
        self.photo_130=[params objectForKey:@"photo_2560"];

        self.isVertical=(self.widthPhoto>=self.heightPhoto)? NO:YES;
    }
    return self;
}
@end
