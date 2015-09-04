//
//  NVTextCell.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 04.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVTextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelText;
+(CGFloat) heightForText:(NSString*) text forWidth:(CGFloat) parentWidth;
@end
