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
#import "NVRepostCell.h"
#import "NVTextCell.h"
#import "NVLikes.h"
#import "NVGroup.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface NVWallVC ()

@end

@implementation NVWallVC
static const NSInteger numberOfWallPostsToGet=5;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfWallPosts=[[NSMutableArray alloc]init];
    self.repostCells=[[NSMutableDictionary alloc]init];
    self.attachmentCells=[[NSMutableDictionary alloc]init];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //self.tableView.estimatedRowHeight = 50.0 ;
    
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
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
        cell.labelDate.text=wallPost.dateOfPost;
        
        NSURL* url;
        if (wallPost.authorUser) {
           cell.labelUser.text=[NSString stringWithFormat:@"%@ %@",wallPost.authorUser.firstName,wallPost.authorUser.lastName];
            url=wallPost.authorUser.photo50;
        } else {
            cell.labelUser.text=[NSString stringWithFormat:@"%@",wallPost.authorGroup.name];
            url=wallPost.authorGroup.photo_50;
        }

        NSURLRequest* request=[NSURLRequest requestWithURL:url];
        __weak NVWallHeaderCell* weakCell=cell;
        
        [cell.imageViewUser setImageWithURLRequest:request placeholderImage:nil
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                               [weakCell.imageViewUser setImage:image];
                                               [weakCell layoutSubviews];
                                               
                                           } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                               
                                           }];
        cell.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.1];
        return cell;
    } else if ([[wallPost.arrayOfDataNames objectAtIndex:indexPath.row] isEqualToString:@"text"]) {
        static NSString* identifier2 = @"textCell";
        NVTextCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier2];
        cell.labelText.text=wallPost.text;
        //NSLog(@"wallPost %@",wallPost.text);

        return cell;
    } else if ([[wallPost.arrayOfDataNames objectAtIndex:indexPath.row] isEqualToString:@"attachments"]) {
        NVAttachmentCell* cell=[self.attachmentCells objectForKey:[self keyForIndexPath:indexPath]];
        return cell;
    } else if ([[wallPost.arrayOfDataNames objectAtIndex:indexPath.row] isEqualToString:@"repost"]) {
        
        NVRepostCell* cell=[self.repostCells objectForKey:[self keyForIndexPath:indexPath]];
        
        return cell;
    }
    
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NVWallPost* wallPost=[self.arrayOfWallPosts objectAtIndex:indexPath.section];
    
    if ([[wallPost.arrayOfDataNames objectAtIndex:indexPath.row] isEqualToString:@"attachments"]){
        NVAttachmentCell* cell=nil;
        if ([self.attachmentCells objectForKey:indexPath]) {
            cell=[self.attachmentCells objectForKey:indexPath];
        } else {
            NSLog(@"attach %@",wallPost.attachments);
            cell=[[NVAttachmentCell alloc]initWithAttachments:wallPost.attachments andParentRect:self.tableView.bounds];
            [self.attachmentCells setObject:cell forKey:[self keyForIndexPath:indexPath]];
        }
        return CGRectGetMinY(cell.lastFrame);
    } else if ([[wallPost.arrayOfDataNames objectAtIndex:indexPath.row] isEqualToString:@"repost"]){
        NVRepostCell* cell=nil;
        if ([self.repostCells objectForKey:indexPath]) {
            cell=[self.repostCells objectForKey:indexPath];
        } else {
            cell=[[NVRepostCell alloc]initWithWallPost:wallPost.repost andParentRect:self.tableView];
            [self.repostCells setObject:cell forKey:[self keyForIndexPath:indexPath]];
        }
        return CGRectGetHeight(cell.tableView.bounds);
    } else if ([[wallPost.arrayOfDataNames objectAtIndex:indexPath.row] isEqualToString:@"text"]){
        
        return [NVTextCell heightForText:wallPost.text forWidth:CGRectGetWidth(self.tableView.bounds)];

    } else {
        return 50.f;
    }
    
}
- (NSIndexPath *)keyForIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath class] == [NSIndexPath class]) {
        return indexPath;
    }
    return [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
}
#pragma mark - UITableViewDelegate
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==[self.arrayOfWallPosts count]-1) {
        [self refreshTable];
    }
    //
}*/
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGRect rect=CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 1);
    UIView *view=[[UIView alloc]initWithFrame:rect];
    view.backgroundColor=[UIColor grayColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if (section==[self.arrayOfWallPosts count]-1) {
        [self refreshTable];
    }
}
/*
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    if ([cell isKindOfClass:[NVAttachmentCell class]]) {
        cell=nil;
    } else if ([cell isKindOfClass:[NVRepostCell class]]){
        cell=nil;
    }
}
 */
@end
