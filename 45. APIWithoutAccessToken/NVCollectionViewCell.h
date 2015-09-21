//
//  NVCollectionViewCell.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 20.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *actionDeleteImage;

@end
