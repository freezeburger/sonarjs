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

@interface DKCommentsTableViewController ()

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



#pragma mark - Helpers

- (void)loadComments
{
    [[UIApplication sharedApplication] showNetworkActivityIndicator];
    [self.refreshControl beginRefreshing];
    [self.tableView scrollRectToVisible:self.refreshControl.frame animated:NO];

    [[DKEchoJS sharedInstance] retrieveCommentsForArticleId:self.articleId success:^(id comments){        
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
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Comment";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
