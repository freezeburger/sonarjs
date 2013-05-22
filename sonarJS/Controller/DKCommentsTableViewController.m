//
//  DKCommentsTableViewController.m
//  sonarJS
//
//  Created by Damien Klinnert on 21.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKCommentsTableViewController.h"
#import "UIApplication+NetworkActivityManager.h"
#import "DKEchoJS.h"
#import "DKCommentTableViewCell.h"

@interface DKCommentsTableViewController ()
@property (nonatomic, strong) NSArray *comments;
@end

@implementation DKCommentsTableViewController

#pragma mark - Setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(handlePullToRefresh:) forControlEvents:UIControlEventValueChanged];
}



#pragma mark - Getters / Setters

- (void)setArticleId:(NSInteger)articleId
{
    _articleId = articleId;
    
    [self loadComments];
}

- (void)setComments:(NSArray *)comments
{
    _comments = comments;
    [self updateUI];
}



#pragma mark - UI

- (void)updateUI
{
    [self.tableView reloadData]; // improve performance by only partially rerendering this
}



#pragma mark - Helpers

- (void)loadComments
{
    [[UIApplication sharedApplication] showNetworkActivityIndicator];
    [self.refreshControl beginRefreshing];
    [self.tableView scrollRectToVisible:self.refreshControl.frame animated:NO];

    [[DKEchoJS sharedInstance] retrieveCommentsForArticleId:self.articleId success:^(id comments){
        self.comments = comments;
        
        [[UIApplication sharedApplication] hideNetworkActivityIndicator];
        [self.refreshControl endRefreshing];
    }];
}



#pragma mark - Action Handlers

- (void)handlePullToRefresh:(id)sender
{
    [self loadComments];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Comment";
    DKCommentTableViewCell *cell = (DKCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.comment = [self.comments[indexPath.item] objectForKey:@"body"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *comment = [self.comments[indexPath.item] objectForKey:@"body"];
    
    CGSize size = [comment sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:[[UIScreen mainScreen] bounds].size];
    return size.height;
}

@end
