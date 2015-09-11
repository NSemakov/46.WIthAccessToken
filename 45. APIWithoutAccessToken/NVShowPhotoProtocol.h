//
//  NVShowPhotoProtocol.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 11.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NVPhoto;
@protocol NVShowPhotoProtocol <NSObject>
- (void) performSegueShowPhoto:(id) sender currentPhoto:(UIImage*)currentPhoto;
@end
