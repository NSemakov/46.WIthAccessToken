//
//  BigPhotoVC.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 11.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVBigPhotoVC : UIViewController
@property (strong,nonatomic) UIImage* currentPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
