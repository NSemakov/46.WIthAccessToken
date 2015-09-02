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
        self.idPhoto=(NSInteger)[params objectForKey:@"id"];
        self.album_id=(NSInteger)[params objectForKey:@"album_id"];
        self.owner_id=(NSInteger)[params objectForKey:@"owner_id"];
        self.user_id=(NSInteger)[params objectForKey:@"user_id"];
        self.widthPhoto=[[params objectForKey:@"width"] unsignedIntegerValue];
        self.heightPhoto=[[params objectForKey:@"height"] unsignedIntegerValue];
        NSLog(@"%ld %ld",(unsigned long)self.widthPhoto,(unsigned long)self.heightPhoto);
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
