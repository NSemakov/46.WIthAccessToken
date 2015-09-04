//
//  NVTextCell.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 04.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVTextCell.h"

@implementation NVTextCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat) heightForText:(NSString*) text forWidth:(CGFloat) parentWidth {
    CGFloat offset=5.0;
    UIFont* font=[UIFont systemFontOfSize:17.f];
    NSShadow* shadow=[[NSShadow alloc]init];
    shadow.shadowOffset=CGSizeMake(0, -1);
    shadow.shadowBlurRadius=0.5;
    
    NSMutableParagraphStyle* paragraph=[[NSMutableParagraphStyle alloc]init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentLeft];
    NSDictionary* attributes=[NSDictionary dictionaryWithObjectsAndKeys:
                              font,NSFontAttributeName,
                              paragraph,NSParagraphStyleAttributeName,
                              shadow,NSShadowAttributeName, nil];
    
    
    CGRect rect=[text boundingRectWithSize:CGSizeMake(parentWidth-2*offset, CGFLOAT_MAX)
                                   options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                attributes:attributes
                                   context:nil];
    //rect=CGRectIntegral(rect);
    NSLog(@"text rect %@",NSStringFromCGRect(rect));
    
    return ceilf(CGRectGetHeight(rect));
}
@end
