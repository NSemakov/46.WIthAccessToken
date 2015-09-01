//
//  NVAttachmentCell.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVAttachmentCell.h"
#import "NVAudio.h"
#import "NVPhoto.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@implementation NVAttachmentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithAttachments:(NSArray*) att
{
    self = [super init];
    if (self) {
        self.audios=[NSMutableArray new];
        self.photos=[NSMutableArray new];
        self.docs=[NSMutableArray new];
        
        for (NSDictionary* obj in att) {
            if ([[obj objectForKey:@"type"] isEqualToString:@"audio"]) {
                NVAudio* audio=[[NVAudio alloc]initWithDictionary:obj];
                [self.audios addObject:audio];
            } else if ([[obj objectForKey:@"type"] isEqualToString:@"photo"]) {
                NVPhoto* photo=[[NVPhoto alloc]initWithDictionary:[obj objectForKey:@"photo"]];
                
                [self.photos addObject:photo];
            } else if ([[obj objectForKey:@"type"] isEqualToString:@"doc"]) {
                [self.docs addObject:obj];
                //!!!!!!!!!!!
            }
        }
        
        [self layoutAttachments];
    }
    return self;
}

- (void) layoutAttachments {
    self.lastFrame=CGRectZero;
    if ([self.photos count]) {
        NSArray* arrayOfPhotos=[self dividePhotosIntoRows:self.photos];
        for (NSInteger i=0; i<[arrayOfPhotos count];i++) {
            NSArray* row=[arrayOfPhotos objectAtIndex:i];
            for (NSInteger j=0; j<[row count]; j++) {
                NVPhoto *photo=[row objectAtIndex:j];
                CGRect rect;
                if (photo.isVertical) {
                    CGFloat widthResized=130.f*(photo.widthPhoto/photo.heightPhoto);
                    rect=CGRectMake(self.lastFrame.origin.x+CGRectGetWidth(self.lastFrame)+5,  self.lastFrame.origin.y+5+130, widthResized, 130);
                    NSLog(@"rect vertical%@",NSStringFromCGRect(rect));
                } else {
                    NSLog(@"%ld %ld",photo.widthPhoto,photo.heightPhoto);
                    CGFloat heightResized=130.f/((double)photo.widthPhoto /(double)photo.heightPhoto);
                    NSLog(@"%f",heightResized);
                    rect=CGRectMake(self.lastFrame.origin.x+5+130, self.lastFrame.origin.y+CGRectGetHeight(self.lastFrame)+5, 130, heightResized);
                    NSLog(@"rect horizontal %@",NSStringFromCGRect(rect));
                }
                //NSLog(@"rect %@",NSStringFromCGRect(rect));
                UIImageView* imageView=[[UIImageView alloc]initWithFrame:rect];
                [self.contentView addSubview:imageView];
                NSLog(@"url %@",photo.photo_130);
                NSURLRequest* request=[NSURLRequest requestWithURL:photo.photo_130];
                
                __weak UIImageView* weakImageView=imageView;
 
                [imageView setImageWithURLRequest:request placeholderImage:nil
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                   [weakImageView setImage:image];
                                                   [weakImageView layoutSubviews];
                                                   
                                               } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                   
                                               }];
                self.lastFrame=imageView.frame;
            }
            
            self.lastFrame=CGRectMake(0, CGRectGetHeight(self.lastFrame)+5, 0, 0);//при переходе на следующую строку длина и ширина =0
        }
    }
    
    
}
- (NSArray*) dividePhotosIntoRows:(NSArray*) arrayOfPhoto{
    NSMutableArray* rows=[NSMutableArray new];
    NSMutableArray* columns=[NSMutableArray new];
    if ([arrayOfPhoto count]) {
       for (NSInteger i=0; i<1;i++) {//rows
            for (NSInteger j=0; j<3;j++) {
                if ((j+i*3)<[arrayOfPhoto count]) {
                    [rows addObject:[arrayOfPhoto objectAtIndex:(j+i*3)]];
                }
                
            }
           [columns addObject:rows];
       }
    }
    //NSLog(@"columns %@",columns);
    return [columns copy];
}
- (void) resizePhotos:(NSArray*) arrayOfPhoto {
    for (NVPhoto* obj in arrayOfPhoto){
        CGFloat ratio=[obj widthPhoto]/[obj heightPhoto] ;
        BOOL isVertical=ratio>1? NO:YES;
        if (isVertical) {
            
        }
    }
}

@end
