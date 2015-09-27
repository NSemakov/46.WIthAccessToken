//
//  NVDetailInfoVC.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVDetailInfoVC.h"
#import "NVFriendsVC.h"
#import "NVUser.h"
#import "NVServerManager.h"
#import "NVPhotoCell.h"
#import "NVFollowersVC.h"
#import "NVSubscriptionVC.h"
#import "NVWallVC.h"
#import "SWRevealViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface NVDetailInfoVC ()

@end


@implementation NVDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.barButton.target=self.revealViewController;
    self.barButton.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
   
    
    self.navigationItem.title=@"Detail Info";
    self.tableView.estimatedRowHeight = 2.0 ;
   
    self.tableView.rowHeight = UITableViewAutomaticDimension; // by itself this line
    [self refreshTableForUser:self.person];
    
    
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    __weak NVDetailInfoVC *weakSelf=self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    [[NVServerManager sharedManager]authorizeUser:^(NVUser *user) {
        NSLog(@"%@ %@",user.firstName,user.lastName);
        weakSelf.person=user;
        [weakSelf refreshTableForUser:[[NVServerManager sharedManager]currentUser]];
    }];
    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void) refreshTableForUser:(NVUser*)user{
    [[NVServerManager sharedManager]getDetailOfFriendFromServer:user.userId onSuccess:^(NVUser *person) {
         //NSMutableArray* arrayOfIndexPaths=[NSMutableArray array];
        self.person=person;
        [self.tableView reloadData];
        /*
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
         */
    } onFailure:^(NSString *error) {
        NSLog(@"%@",error);
    }];
    
        
       
        
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1+[self.person.arrayOfObjects count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"basicCell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            NVPhotoCell* customCell=[tableView dequeueReusableCellWithIdentifier:@"photoCell"];
            [self configureBasicCell:customCell atIndexPath:indexPath];
            return customCell;
        } else if (indexPath.row==1) {
            cell.textLabel.text=@"Подписчики";
        } else if (indexPath.row==2) {
            cell.textLabel.text=@"Подписки";
        } else if (indexPath.row==3) {
            cell.textLabel.text=@"Стена";
        }
    } else if (indexPath.section>0){
        cell.textLabel.text=[self.person.arrayOfObjects objectAtIndex:indexPath.section-1];
    }
    
   return cell;
}
- (void)configureBasicCell:(NVPhotoCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.person.isOnline) {
        cell.label.text=@"Online";
    }
    __weak NVPhotoCell* weakCell=cell;
    NSURLRequest* request=[NSURLRequest requestWithURL:self.person.photo200];
    [cell.photo200 setImageWithURLRequest:request placeholderImage:nil
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                      [weakCell.photo200 setImage:image];
                                      [weakCell layoutSubviews];
                                      //[self.tableView reloadData];
                                      
                                  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                      
                                  }];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section>0) {
        return [self.person.arrayOfNames objectAtIndex:section-1];
    } else {
        return nil;
    }
}
#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0 && indexPath.row==1) {
        [self performSegueWithIdentifier:@"segueFollowers" sender:nil];
    } else if (indexPath.section==0 && indexPath.row==2) {
        [self performSegueWithIdentifier:@"segueSubscription" sender:nil];
    } else if (indexPath.section==0 && indexPath.row==3) {
        [self performSegueWithIdentifier:@"segueShowWall" sender:nil];
    }
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueFollowers"]) {
        NVFollowersVC* vc=segue.destinationViewController;
        vc.person=self.person;
    } else if ([segue.identifier isEqualToString:@"segueSubscription"]) {
        NVSubscriptionVC* vc=segue.destinationViewController;
        vc.person=self.person;
    } else if ([segue.identifier isEqualToString:@"segueShowWall"]) {
        NVWallVC* vc=segue.destinationViewController;
        vc.person=self.person;
        
    }
    
    
}
@end