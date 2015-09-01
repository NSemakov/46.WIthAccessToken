//
//  NVWallVC.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 01.09.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVWallVC.h"
#import "NVServerManager.h"
#import "NVWallHeaderCell.h"
#import "NVWallPost.h"
#import "NVAttachmentCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface NVWallVC ()

@end

@implementation NVWallVC
static const NSInteger numberOfWallPostsToGet=1;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfWallPosts=[[NSMutableArray alloc]init];
    
    [self refreshTable];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshTable{
    [[NVServerManager sharedManager] getWallPostsOfFriendFromServer:[self.person.userId integerValue] Count:numberOfWallPostsToGet withOffset:[self.arrayOfWallPosts count] onSuccess:^(NSArray *wallPosts) {
        NSMutableArray* arrayOfIndexPaths=[NSMutableArray array];
        
        for (NSInteger i=[self.arrayOfWallPosts count]; i<[self.arrayOfWallPosts count]+[wallPosts count]; i++) {
            
            NSIndexPath* newIndexPath=[NSIndexPath indexPathForRow:i inSection:0];
            [arrayOfIndexPaths addObject:newIndexPath];
        }
        [self.arrayOfWallPosts addObjectsFromArray:wallPosts];
        [self.tableView reloadData];
        /*
        [self.tableView beginUpdates];
        //[self.tableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        NSRange range=NSMakeRange([self.arrayOfWallPosts count], [wallPosts count]);
        [self.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:range] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
         */
    } onFailure:^(NSString *error) {
        NSLog(@"%@",error);
    } ];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //NSLog(@" numberOfSectionsInTableView %ld",[self.arrayOfWallPosts count]);
    return [self.arrayOfWallPosts count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   NVWallPost* wallPost=[self.arrayOfWallPosts objectAtIndex:section];
   // NSLog(@"numberOfRowsInSection %ld",[wallPost.arrayOfData count]);
    return [wallPost.arrayOfData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NVWallPost* wallPost=[self.arrayOfWallPosts objectAtIndex:indexPath.section];
    
    if ([[wallPost.arrayOfDataNames objectAtIndex:indexPath.row] isEqualToString:@"author"]) {
        static NSString* identifier = @"headerCell";
        NVWallHeaderCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        NVWallPost* wallPost=[self.arrayOfWallPosts objectAtIndex:indexPath.section];
        //NSLog(@"wallPost %@ date %@", cell, wallPost.date);
       // NSLog(@"date %@", wallPost.date);
        cell.labelDate.text=wallPost.dateOfPost;
        cell.labelUser.text=[NSString stringWithFormat:@"%@ %@",wallPost.author.firstName,wallPost.author.lastName];
        NSURL* url=wallPost.author.photo50;
        NSURLRequest* request=[NSURLRequest requestWithURL:url];
        __weak NVWallHeaderCell* weakCell=cell;
        
        [cell.imageViewUser setImageWithURLRequest:request placeholderImage:nil
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                               [weakCell.imageViewUser setImage:image];
                                               [weakCell layoutSubviews];
                                               
                                           } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                               
                                           }];
        
        return cell;
    } else if ([[wallPost.arrayOfDataNames objectAtIndex:indexPath.row] isEqualToString:@"text"]) {
        static NSString* identifier2 = @"textCell";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier2];
        cell.textLabel.text=wallPost.text;
        NSLog(@"wallPost %@",wallPost.text);

        return cell;
    } else if ([[wallPost.arrayOfDataNames objectAtIndex:indexPath.row] isEqualToString:@"attachments"]) {
        
    }

    return nil;
}


@end
