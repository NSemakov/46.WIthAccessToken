//
//  ViewController.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVFriendsVC.h"
#import "NVUser.h"
#import "NVServerManager.h"
#import "NVDetailInfoVC.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface NVFriendsVC ()

@end
static const NSInteger numberOfFriendsToGet=20;
@implementation NVFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.arrayOfFriends=[[NSMutableArray alloc]init];
    [self refreshTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) refreshTable{
        [[NVServerManager sharedManager] getFriendsFromServerCount:numberOfFriendsToGet withOffset:[self.arrayOfFriends count] onSuccess:^(NSArray *friends) {

        NSMutableArray* arrayOfIndexPaths=[NSMutableArray array];
        for (NSInteger i=[self.arrayOfFriends count]; i<[self.arrayOfFriends count]+[friends count]; i++) {
            NSIndexPath* newIndexPath=[NSIndexPath indexPathForRow:i inSection:0];
            [arrayOfIndexPaths addObject:newIndexPath];
        }
        [self.arrayOfFriends addObjectsFromArray:friends];
        [self.tableView beginUpdates];   
        [self.tableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
    } onFailure:^(NSString * error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayOfFriends count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"cell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NVUser* friend=[self.arrayOfFriends objectAtIndex:indexPath.row];
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",friend.firstName, friend.lastName];
    NSURLRequest* request1=[NSURLRequest requestWithURL:friend.photo50];
    
    __weak UITableViewCell* weakCell=cell;
    [cell.imageView setImageWithURLRequest:request1 placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       [weakCell.imageView setImage:image];
                                       [weakCell layoutSubviews];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==[self.arrayOfFriends count]-1) {
       [self refreshTable]; 
    }
    //
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    [cell.imageView setImage:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"segueDetailPersonInfo" sender:indexPath];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueDetailPersonInfo"]) {
        NVDetailInfoVC* vc= (NVDetailInfoVC*)segue.destinationViewController;
        vc.userIds=[[self.arrayOfFriends objectAtIndex:[(NSIndexPath*)sender row]] userId];
        NSLog(@"userIds to send %@",[[self.arrayOfFriends objectAtIndex:[(NSIndexPath*)sender row]] userId]);
    }
}
@end
