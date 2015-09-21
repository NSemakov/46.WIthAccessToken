//
//  NVAddPostVC.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 18.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RBImagePickerDelegate.h"
#import "RBImagePickerDataSource.h"
#import "NVUser.h"
@class RBImagePickerController;
@interface NVAddPostVC : UIViewController <UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,RBImagePickerDelegate, UINavigationControllerDelegate,RBImagePickerDataSource>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic) NVUser* person;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) RBImagePickerController* imagePicker;
@property (strong,nonatomic) NSMutableArray* arrayOfSelectedImages;
- (IBAction)actionAddPhotos:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfCollectionView;
- (IBAction)actionAddPostToWall:(UIBarButtonItem *)sender;

@end
