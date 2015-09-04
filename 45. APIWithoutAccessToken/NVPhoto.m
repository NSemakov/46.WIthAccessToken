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

- (instancetype)initWithDictionary:(NSDictionary*) params
{
    self = [super init];
    if (self) {
        self.idPhoto=[[params objectForKey:@"id"]integerValue];
        self.album_id=[[params objectForKey:@"album_id"]integerValue];
        self.owner_id=[[params objectForKey:@"owner_id"]integerValue];
        self.user_id=[[params objectForKey:@"user_id"]integerValue];
        self.widthPhoto=[[params objectForKey:@"width"] unsignedIntegerValue];
        self.heightPhoto=[[params objectForKey:@"height"] unsignedIntegerValue];
        if (!self.widthPhoto) {
            self.widthPhoto=604;
        }
        if (!self.heightPhoto){
            self.heightPhoto=604;
        }
        self.photo_75=[NSURL URLWithString:[params objectForKey:@"photo_75"]];
        self.photo_130=[NSURL URLWithString:[params objectForKey:@"photo_130"]];
        //NSLog(@"%@",self.photo_130);
        self.photo_604=[NSURL URLWithString:[params objectForKey:@"photo_604"]];
        self.photo_2560=[NSURL URLWithString:[params objectForKey:@"photo_2560"]];
        self.isVertical=(self.widthPhoto>=self.heightPhoto)? NO:YES;
    }
    return self;
}
@end
