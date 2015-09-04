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
#import "NVDocument.h"
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
            //NSLog(@"%@",obj);
            if ([[obj objectForKey:@"type"] isEqualToString:@"audio"]) {
                NVAudio* audio=[[NVAudio alloc]initWithDictionary:[obj objectForKey:@"audio"]];
                [self.audios addObject:audio];
            } else if ([[obj objectForKey:@"type"] isEqualToString:@"photo"]) {
                NVPhoto* photo=[[NVPhoto alloc]initWithDictionary:[obj objectForKey:@"photo"]];
                
                [self.photos addObject:photo];
            } else if ([[obj objectForKey:@"type"] isEqualToString:@"doc"]) {
                [self.docs addObject:[obj objectForKey:@"doc"]];
                //!!!!!!!!!!!
            }
        }
        
        [self layoutAttachments];
    }
    return self;
}

- (void) layoutAttachments {
    self.lastFrame=CGRectZero;
    //adding photo
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
                } else {
                    CGFloat heightResized=fixedSideSize/((double)photo.widthPhoto /(double)photo.heightPhoto);
                    rect=CGRectMake(0,0, fixedSideSize, heightResized);
                }
                UIImageView* imageView=[[UIImageView alloc]initWithFrame:rect];
                [arrayOfImageViewsInRow addObject:imageView];
                NSURLRequest* request=[NSURLRequest requestWithURL:photo.photo_604];
                
                __weak UIImageView* weakImageView=imageView;
                
                [imageView setImageWithURLRequest:request placeholderImage:nil
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                              [weakImageView setImage:image];
                                              [weakImageView layoutSubviews];
                                              
                                          } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                          }];
            }
            
            [self layoutImagesRow:arrayOfImageViewsInRow];
            
            
        }
    }
    //adding audio
    if ([self.audios count]) {
        for (NVAudio* obj in self.audios){
            [self layoutAudio:obj];
        }
    }
    if ([self.docs count]) {
        for (NVDocument* obj in self.audios){
            [self layoutDocument:obj];
        }
    }
}
- (void) layoutImagesRow:(NSMutableArray*) arrayOfImageViewsInRow {
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
- (void) layoutAudio:(NVAudio*) obj{
    //NVAudio* obj1=obj;
    CGRect audioRect=CGRectMake(8, CGRectGetMinY(self.lastFrame), 25, 25);
    UIImageView* view=[[UIImageView alloc]initWithFrame:audioRect];
    view.image=[UIImage imageNamed:@"playAudio.jpg"];
    //set artist label
    CGRect audioArtistRect=CGRectMake(CGRectGetMaxX(view.frame)+3, CGRectGetMinY(self.lastFrame), CGRectGetWidth(self.parentTableViewRect)-26-2, 12);
    UILabel* labelAudioArtist=[[UILabel alloc]initWithFrame:audioArtistRect];
    labelAudioArtist.text=obj.artist;
    UIFont *font = [UIFont boldSystemFontOfSize:12.f];
    [labelAudioArtist setFont:font];
    //set title label
    CGRect audioTitleRect=CGRectMake(CGRectGetMaxX(view.frame)+3, CGRectGetMinY(self.lastFrame)+12+1, CGRectGetWidth(self.parentTableViewRect)-26-2-50-2, 12);
    UILabel* labelAudioTitle=[[UILabel alloc]initWithFrame:audioTitleRect];
    labelAudioTitle.text=obj.title;
    font = [UIFont systemFontOfSize:11.f];
    [labelAudioTitle setFont:font];
    //set duration label
    CGRect audioDurationRect=CGRectMake(CGRectGetMaxX(audioTitleRect)+2, CGRectGetMinY(self.lastFrame)+12+1, 50, 12);
    UILabel* labelAudioDuration=[[UILabel alloc]initWithFrame:audioDurationRect];
    int seconds = obj.duration % 60;
    int minutes = (obj.duration / 60) % 60;
    //int hours = obj.duration / 3600;
    
    labelAudioDuration.text=[NSString stringWithFormat:@"%d:%02d",minutes, seconds];
    font = [UIFont systemFontOfSize:11.f];
    [labelAudioDuration setFont:font];
    
    [self addSubview:view];
    [self addSubview:labelAudioArtist];
    [self addSubview:labelAudioTitle];
    [self addSubview:labelAudioDuration];
    
    self.lastFrame=CGRectMake(0, CGRectGetMaxY(view.frame)+5, 0, 0);//при переходе на следующую строку длина и ширина =0
}

- (void) layoutDocument:(NVDocument*) obj{
    
    CGRect documentRect=CGRectMake(8, CGRectGetMinY(self.lastFrame), 25, 25);
    UIImageView* view=[[UIImageView alloc]initWithFrame:documentRect];
    view.image=[UIImage imageNamed:@"docIcon.png"];
    //set artist label
    CGRect docTitleRect=CGRectMake(CGRectGetMaxX(view.frame)+3, CGRectGetMinY(self.lastFrame), CGRectGetWidth(self.parentTableViewRect)-26-2, 12);
    UILabel* labelDocTitle=[[UILabel alloc]initWithFrame:docTitleRect];
    labelDocTitle.text=[NSString stringWithFormat:@"%@.%@",obj.title,obj.extension];
    UIFont *font = [UIFont boldSystemFontOfSize:12.f];
    [labelDocTitle setFont:font];
    //set title label
    CGRect docSubtitleRect=CGRectMake(CGRectGetMaxX(view.frame)+3, CGRectGetMinY(self.lastFrame)+12+1, CGRectGetWidth(self.parentTableViewRect)-26-2, 12);
    UILabel* labelDocSubtitle=[[UILabel alloc]initWithFrame:docSubtitleRect];
    
    labelDocSubtitle.text=[NSString stringWithFormat:@"Документ %@, %@",obj.extension,[NSByteCountFormatter stringFromByteCount:obj.size countStyle:NSByteCountFormatterCountStyleFile]];
    font = [UIFont systemFontOfSize:11.f];
    [labelDocSubtitle setFont:font];
    
    [self addSubview:view];
    [self addSubview:labelDocTitle];
    [self addSubview:labelDocSubtitle];
    
    self.lastFrame=CGRectMake(0, CGRectGetMaxY(view.frame)+5, 0, 0);//при переходе на следующую строку длина и ширина =0
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
