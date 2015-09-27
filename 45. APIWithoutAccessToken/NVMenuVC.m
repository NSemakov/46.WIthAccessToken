//
//  MVMenuVCTableViewController.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 27.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVMenuVC.h"
#import "SWRevealViewController.h"
#import "NVDetailInfoVC.h"
#import "NVFriendsVC.h"
#import "NVServerManager.h"
@interface NVMenuVC () <SWRevealViewControllerDelegate>

@end

@implementation NVMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.revealViewController.delegate=self;
    self.arrayOfMenuItems=[NSArray arrayWithObjects:@"myPage",@"friends", nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.arrayOfMenuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier=[self.arrayOfMenuItems objectAtIndex:indexPath.row];
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    /*
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text=[self.arrayOfMenuItems objectAtIndex:indexPath.row];
     */
    return cell;

}




#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 
 
 if ( [segue isKindOfClass: [SWRevealViewControllerSegueSetController class]] ) {
     
     SWRevealViewControllerSegueSetController *swSegue = (SWRevealViewControllerSegueSetController*) segue;
     UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
     if ([swSegue.identifier isEqualToString:@"friendsVC"]) {
         NVFriendsVC* vc=swSegue.destinationViewController;
         [navController pushViewController:vc animated:YES];
     } else if ([swSegue.identifier isEqualToString:@"detailVC"]){
         NVDetailInfoVC* vc=swSegue.destinationViewController;
         vc.person=[[NVServerManager sharedManager]currentUser];
         [navController pushViewController:vc animated:YES];
         
     }
     [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
 };
     
     
 
 
 
 }

@end
