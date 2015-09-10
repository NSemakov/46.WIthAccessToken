//
//  NVLikeRepostComCell.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 05.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVLikeRepostComCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
@property (weak, nonatomic) IBOutlet UIButton *buttonRepost;
@property (weak, nonatomic) IBOutlet UIButton *buttonComment;
- (IBAction)actionShowComments:(UIButton *)sender;
- (IBAction)actionLike:(UIButton *)sender;
- (IBAction)actionRepost:(UIButton *)sender;

@end
