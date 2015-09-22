//
//  NVAddPostVC.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 18.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVAddPostVC.h"
#import "RBImagePickerController.h"
#import "NVCollectionViewCell.h"
#import "NVServerManager.h"
#import "NVUser.h"
@interface NVAddPostVC ()

@end
const NSInteger maxNumberOfImagesForUpload=6;
@implementation NVAddPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfSelectedImages=[NSMutableArray new];
    //self.textView.scrollEnabled=NO;
    self.widthOfScrollView.constant=CGRectGetWidth(self.view.bounds);;
    self.widthOfCollectionView.constant=CGRectGetWidth(self.view.bounds);
    self.widthOfTextView.constant=CGRectGetWidth(self.view.bounds);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) willShowKeyBoard:(NSNotification *)notification  {
    [self.view layoutIfNeeded];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] valueForKey: UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval animationDuration = [[[notification userInfo] valueForKey: UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //NSLog(@"duration %f",animationDuration);
    CGRect keyboardRect = [(NSValue *)[[notification userInfo] objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    self.spaceFromBottom.constant=CGRectGetHeight(keyboardRect);
    [UIView animateWithDuration:animationDuration delay:0 options:(int)animationCurve animations:^{
        [self.view layoutIfNeeded];// Called on parent view
    } completion:nil];

}
- (void) willHideKeyBoard:(NSNotification *)notification  {
    [self.view layoutIfNeeded];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] valueForKey: UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval animationDuration = [[[notification userInfo] valueForKey: UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //CGRect keyboardRect = [(NSValue *)[[notification userInfo] objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.spaceFromBottom.constant=0;
    [UIView animateWithDuration:animationDuration delay:0 options:(int)animationCurve animations:^{
        [self.view layoutIfNeeded];// Called on parent view
    } completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITextViewDelegate

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.arrayOfSelectedImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier=@"photoCollectionViewCell";
    NVCollectionViewCell* cell=[self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //NSString* imagePath=[(NSURL*)[self.arrayOfSelectedImages objectAtIndex:indexPath.row] absoluteString];
    cell.imageView.image=[self.arrayOfSelectedImages objectAtIndex:indexPath.row];//[UIImage imageWithContentsOfFile:imagePath];
    cell.delegate=self;
    return cell;
}
#pragma mark -UICollectionViewDelegate


#pragma mark -RBImagePickerDelegate
-(void)imagePickerController:(RBImagePickerController *)imagePicker didFinishPickingImagesWithURL:(NSArray *)imageURLS{
    
    [self.arrayOfSelectedImages addObjectsFromArray:imageURLS];
    [self.collectionView reloadData];
}
-(void)imagePickerControllerDidCancel:(RBImagePickerController *)imagePicker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - RBImagePickerDataSource

-(NSInteger)imagePickerControllerMaxSelectionCount:(RBImagePickerController *)imagePicker{
    return maxNumberOfImagesForUpload-[self.arrayOfSelectedImages count];
}
-(NSInteger)imagePickerControllerMinSelectionCount:(RBImagePickerController *)imagePicker{
    return 0;
}
#pragma mark - actions
- (IBAction)actionAddPhotos:(UIBarButtonItem *)sender {
    self.imagePicker = [[RBImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.dataSource = self; // To control selection count
    self.imagePicker.selectionType = RBMultipleImageSelectionType;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (IBAction)actionAddPostToWall:(UIBarButtonItem *)sender {
    [[NVServerManager sharedManager] postWallCreateCommentText:self.textView.text image:[self.arrayOfSelectedImages copy] onGroupWall:[[[NVServerManager sharedManager]currentUser]userId] onSuccess:^(id result) {
        NSLog(@"successful complete! %@",self.person.firstName);
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error %@",[error description]);
    }];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - NVCollectionViewCellProtocol
-(void)removeImageFromSelected:(NVCollectionViewCell *)cell{
    NSIndexPath* indexPath=[self.collectionView indexPathForCell:cell];
    [self.arrayOfSelectedImages removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

