//
//  NVSubscriptionVC.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 29.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVSubscriptionVC.h"
#import "NVServerManager.h"
#import "NVUser.h"
#import "NVGroup.h"
#import "NVWallVC.h"
#import "NVSubcription.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface NVSubscriptionVC ()

@end

@implementation NVSubscriptionVC
static const NSInteger numberOfSubscriptionsToGet=20;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Подписки";
    //self.tableView.allowsSelection = NO;
    self.arrayOfSubscription=[[NSMutableArray alloc]init];
    [self refreshTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshTable{
    [[NVServerManager sharedManager] getSubscriptionsFromServer:self.person.userId Count:numberOfSubscriptionsToGet withOffset:[self.arrayOfSubscription count] onSuccess:^(NSArray *subscriptions) {
        
        NSMutableArray* arrayOfIndexPaths=[NSMutableArray array];
        for (NSInteger i=[self.arrayOfSubscription count]; i<[self.arrayOfSubscription count]+[subscriptions count]; i++) {
            NSIndexPath* newIndexPath=[NSIndexPath indexPathForRow:i inSection:0];
            [arrayOfIndexPaths addObject:newIndexPath];
        }
        [self.arrayOfSubscription addObjectsFromArray:subscriptions];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
    } onFailure:^(NSString * error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayOfSubscription count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"cell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    NVSubcription* subscription=[self.arrayOfSubscription objectAtIndex:indexPath.row];
    NSString* textForLabel;
    if (subscription.person) {
        textForLabel=[NSString stringWithFormat:@" %@ %@",subscription.person.firstName,subscription.person.lastName];
    } else {
        textForLabel=[NSString stringWithFormat:@" %@",subscription.name];
    }
    cell.textLabel.text=textForLabel;
    NSURLRequest* request1=[NSURLRequest requestWithURL:subscription.photo50];
    //NSLog(@"photo %@",[subscription.photo50 path]);
    __weak UITableViewCell* weakCell=cell;
    [cell.imageView setImageWithURLRequest:request1 placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       [weakCell.imageView setImage:image];
                                       [weakCell layoutSubviews];
                                       
                                   } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                       
                                   }];
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==[self.arrayOfSubscription count]-10) {
        [self refreshTable];
    }
    //
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    [cell.imageView setImage:nil];
}

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 //[self performSegueWithIdentifier:@"segueDetailPersonInfo" sender:indexPath];
     UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
     NVWallVC* vc=[sb instantiateViewControllerWithIdentifier:@"NVWallVC"];
     if ([[[self arrayOfSubscription] objectAtIndex:indexPath.row] person]) {
         vc.person=[[[self arrayOfSubscription] objectAtIndex:indexPath.row]person];
     } else {
         vc.group=[[[self arrayOfSubscription] objectAtIndex:indexPath.row] group];
         
     }
     [self.navigationController pushViewController:vc animated:YES];
 }
 
/*
 - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if ([segue.identifier isEqualToString:@"segueDetailPersonInfo"]) {
 NVDetailInfoVC* vc= (NVDetailInfoVC*)segue.destinationViewController;
 vc.userIds=[[self.arrayOfFriends objectAtIndex:[(NSIndexPath*)sender row]] userId];
 NSLog(@"userIds to send %@",[[self.arrayOfFriends objectAtIndex:[(NSIndexPath*)sender row]] userId]);
 }
 }
 */
@end