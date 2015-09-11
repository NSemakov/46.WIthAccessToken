//
//  BigPhotoVC.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 11.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVBigPhotoVC.h"

@interface NVBigPhotoVC ()

@end

@implementation NVBigPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.image=self.currentPhoto;
    UISwipeGestureRecognizer* swipeGestureRec=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissVC:)];
    swipeGestureRec.direction=UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGestureRec];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) dismissVC:(UISwipeGestureRecognizer *) rec {
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
