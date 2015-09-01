//
//  NVFriend.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVUser.h"

@implementation NVUser
- (instancetype)initWithDictionary:(NSDictionary*) params 
{
    self = [super init];
    if (self) {
        self.firstName=[params objectForKey:@"first_name"];
        self.lastName=[params objectForKey:@"last_name"];
        self.photo50=[NSURL URLWithString:[params objectForKey:@"photo_50"]];
        self.photo200=[NSURL URLWithString:[params objectForKey:@"photo_200"]];
        self.country=[[params objectForKey:@"country"]objectForKey:@"title"];
        self.city=[[params objectForKey:@"city"]objectForKey:@"title"];
        self.userId=[params objectForKey:@"id"];
        self.education=[params objectForKey:@"education_form"];
        self.universities=[params objectForKey:@"university_name"];
        self.status=[params objectForKey:@"status"];
        
        long long lastSeen=[[[params objectForKey:@"last_seen"] objectForKey:@"time"] longLongValue];
        NSDate* dateLastSeen=[NSDate dateWithTimeIntervalSince1970:lastSeen];
        NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        self.last_seen=[NSString stringWithFormat:@"%@",[formatter stringFromDate:dateLastSeen]];
        self.isOnline=[[params objectForKey:@"online"] boolValue];
        self.interests=[params objectForKey:@"interests"];
        self.music=[params objectForKey:@"music"];
        self.movies=[params objectForKey:@"movies"];
        self.tv=[params objectForKey:@"tv"];
        self.games=[params objectForKey:@"games"];
        self.about=[params objectForKey:@"about"];
        self.quotes=[params objectForKey:@"quotes"];
        
        [self fullfillArrayOfNamesAndArrayOfObjects];
    }
    return self;

}

- (void) fullfillArrayOfNamesAndArrayOfObjects{
    NSMutableArray* arrayOfNames=[NSMutableArray new];
    NSMutableArray* arrayOfObjects=[NSMutableArray new];

    if (self.firstName) {
        [arrayOfNames addObject:@"Имя"];
        [arrayOfObjects addObject:self.firstName];
    }
    if (self.lastName){
        [arrayOfNames addObject:@"Фамилия"];
        [arrayOfObjects addObject:self.lastName];
        
    }
    if (self.country){
        [arrayOfNames addObject:@"Страна"];
        [arrayOfObjects addObject:self.country];
    }
    if (self.city){
        [arrayOfNames addObject:@"Город"];
        [arrayOfObjects addObject:self.city];
    }
    if (self.education){
        [arrayOfNames addObject:@"Форма обучения"];
        [arrayOfObjects addObject:self.education];
    }
    if (self.universities){
        [arrayOfNames addObject:@"Университет"];
        [arrayOfObjects addObject:self.universities];
    }
    if ([self.status length]>0){
        [arrayOfNames addObject:@"Статус"];
        [arrayOfObjects addObject:self.status];
    }
    if (self.last_seen && !self.isOnline){
        [arrayOfNames addObject:@"Последний раз в сети:"];
        [arrayOfObjects addObject:self.last_seen];
    }
    if ([self.interests length]>0){
        [arrayOfNames addObject:@"Интересы"];
        [arrayOfObjects addObject:self.interests];
    }
    if ([self.music length]>0){
        [arrayOfNames addObject:@"Музыка"];
        [arrayOfObjects addObject:self.music];
    } else if ([self.movies length]>0){
        [arrayOfNames addObject:@"Кино"];
        [arrayOfObjects addObject:self.movies];
    }
    if ([self.tv length]>0){
        [arrayOfNames addObject:@"Телепередачи"];
        [arrayOfObjects addObject:self.tv];
    }
    if ([self.games length]>0){
        [arrayOfNames addObject:@"Игры"];
        [arrayOfObjects addObject:self.games];
    }
    if ([self.about length]>0){
        [arrayOfNames addObject:@"О себе"];
        [arrayOfObjects addObject:self.about];
    }
    if ([self.quotes length]>0){
        [arrayOfNames addObject:@"Цитаты"];
        [arrayOfObjects addObject:self.quotes];
    }
    self.arrayOfNames=arrayOfNames;
    self.arrayOfObjects=arrayOfObjects;

}
@end
