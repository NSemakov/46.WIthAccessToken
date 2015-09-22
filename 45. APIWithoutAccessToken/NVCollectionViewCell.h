//
//  NVCollectionViewCell.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 20.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NVCollectionViewCellProtocol;
@interface NVCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)actionDeleteImage:(UIButton *)sender;

@property (weak,nonatomic) id<NVCollectionViewCellProtocol> delegate;
@end

@protocol NVCollectionViewCellProtocol
@required
- (void) removeImageFromSelected:(NVCollectionViewCell*) cell;
@end