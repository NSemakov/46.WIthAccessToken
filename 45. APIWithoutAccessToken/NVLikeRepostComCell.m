//
//  NVLikeRepostComCell.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 05.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVLikeRepostComCell.h"

@implementation NVLikeRepostComCell

- (void)awakeFromNib {
    // Initialization code
    UIColor* highlightedColor=[UIColor colorWithRed:157.f/255.f green:157.f/255.f blue:157.f/255.f alpha:1];
    [self.buttonLike setBackgroundImage:[self imageWithColor:highlightedColor] forState:UIControlStateHighlighted];
    [self.buttonRepost setBackgroundImage:[self imageWithColor:highlightedColor] forState:UIControlStateHighlighted];
    [self.buttonComment setBackgroundImage:[self imageWithColor:highlightedColor] forState:UIControlStateHighlighted];
    self.buttonLike.layer.cornerRadius=4.f;
    self.buttonRepost.layer.cornerRadius=4.f;
    self.buttonComment.layer.cornerRadius=4.f;
    self.buttonLike.clipsToBounds=YES;
    self.buttonRepost.clipsToBounds=YES;
    self.buttonComment.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (IBAction)actionShowComments:(UIButton *)sender {
}

- (IBAction)actionLike:(UIButton *)sender {
}

- (IBAction)actionRepost:(UIButton *)sender {
}
@end
