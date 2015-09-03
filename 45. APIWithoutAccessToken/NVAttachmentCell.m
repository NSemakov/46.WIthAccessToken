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
}
- (instancetype)initWithAttachments:(NSArray*) att andParentRect:(CGRect) parentRect
{
    self = [super init];
    if (self) {
        self.parentTableViewRect=parentRect;
        
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
        CGFloat fixedSideSize=604.f;
        for (NSInteger i=0; i<[arrayOfPhotos count];i++) {
            NSMutableArray* arrayOfImageViewsInRow=[NSMutableArray new];
            NSArray* row=[arrayOfPhotos objectAtIndex:i];
            for (NSInteger j=0; j<[row count]; j++) {
                NVPhoto *photo=[row objectAtIndex:j];
                CGRect rect;//прямоугольник, который определяется по размерам фото
                if (photo.isVertical) {
                    CGFloat widthResized=fixedSideSize*((double)photo.widthPhoto/(double)photo.heightPhoto);
                    
                    rect=CGRectMake(0,0, widthResized, fixedSideSize);
                    //NSLog(@"rect vertical%@",NSStringFromCGRect(rect));
                } else {
                    //NSLog(@"%ld %ld",photo.widthPhoto,photo.heightPhoto);
                    CGFloat heightResized=fixedSideSize/((double)photo.widthPhoto /(double)photo.heightPhoto);
                    //NSLog(@"%f",heightResized);
                    
                    rect=CGRectMake(0,0, fixedSideSize, heightResized);
                    //NSLog(@"rect horizontal %@",NSStringFromCGRect(rect));
                }
                
                //NSLog(@"rect %@",NSStringFromCGRect(rect));
                UIImageView* imageView=[[UIImageView alloc]initWithFrame:rect];
                [arrayOfImageViewsInRow addObject:imageView];
                //NSLog(@"url %@",photo.photo_604);
                NSURLRequest* request=[NSURLRequest requestWithURL:photo.photo_604];
                
                __weak UIImageView* weakImageView=imageView;
                
                [imageView setImageWithURLRequest:request placeholderImage:nil
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                              [weakImageView setImage:image];
                                              [weakImageView layoutSubviews];
                                              
                                          } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                              
                                          }];
                //self.lastFrame=imageView.frame;//для позиционирования следующего изображения
            }
            //resize to screen width
            CGFloat sumWidth=0;
            for (UIImageView* view in arrayOfImageViewsInRow){
                sumWidth+=CGRectGetWidth(view.bounds)+25;//2 pixels - indents
            }
            CGFloat sumResizedWidth=0;
            for (UIImageView* view in arrayOfImageViewsInRow){
                CGFloat ratio=CGRectGetWidth(view.bounds)/CGRectGetHeight(view.bounds);
                CGFloat newWidth=CGRectGetWidth(self.parentTableViewRect)*CGRectGetWidth(view.bounds)/sumWidth;
                CGFloat newHeight=newWidth/ratio;
                
                view.frame=CGRectMake(CGRectGetMaxX(self.lastFrame), self.lastFrame.origin.y, newWidth, newHeight);
                view.frame =CGRectIntegral(view.frame);
                self.lastFrame=view.frame; // для правильного вычисления высоты ячейки + позиционирования следующей строки фотографий
                //NSLog(@"rect in array%@",NSStringFromCGRect(view.frame));
                sumResizedWidth+=CGRectGetWidth(view.bounds);
            }
            CGFloat equalizingConstant=(double)(CGRectGetWidth(self.parentTableViewRect)-sumResizedWidth)/(double)([arrayOfImageViewsInRow count]+1);
            //NSLog(@"equalizingConstant %f sumResizedWidth %f CGRectGetWidth(self.bounds) %f",equalizingConstant,sumResizedWidth,CGRectGetWidth(self.parentTableViewRect));
            //--end of resizing to screen width
            //equalizing in center
            UIImageView* tempView=[[UIImageView alloc]init];
            tempView.frame=CGRectZero;
            for (UIImageView* view in arrayOfImageViewsInRow){
                view.frame=CGRectMake(CGRectGetMaxX(tempView.frame)+equalizingConstant, CGRectGetMinY(view.frame), CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
                view.frame =CGRectIntegral(view.frame);
                tempView.frame=view.frame;
                [self addSubview:view];
            }
            //sorting array to get highest image to prevent intersection with next row
            [arrayOfImageViewsInRow sortUsingComparator:^NSComparisonResult(UIImageView* obj1, UIImageView* obj2) {
                if (CGRectGetHeight(obj1.bounds)>CGRectGetHeight(obj2.bounds)) {
                    return NSOrderedAscending;
                } else if (CGRectGetHeight(obj1.bounds)<CGRectGetHeight(obj2.bounds)){
                    return  NSOrderedDescending;
                } else {
                    return NSOrderedSame;
                }
            }];
            
            self.lastFrame=CGRectMake(0, CGRectGetMaxY([[arrayOfImageViewsInRow firstObject] frame])+5, 0, 0);//при переходе на следующую строку длина и ширина =0
        }
    }
    
    
}
- (NSArray*) dividePhotosIntoRows:(NSArray*) arrayOfPhoto{
    
    NSMutableArray* columns=[NSMutableArray new];
    if ([arrayOfPhoto count]) {
       for (NSInteger i=0; i<((([arrayOfPhoto count]-1)/3)+1);i++) {//3 photo in row
           NSMutableArray* rows=[NSMutableArray new];
            for (NSInteger j=0; j<3;j++) {
                if ((j+i*3)<[arrayOfPhoto count]) {
                    [rows addObject:[arrayOfPhoto objectAtIndex:(j+i*3)]];
                }
                
            }
           [columns addObject:rows];
       }
    }
    return columns ;
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
