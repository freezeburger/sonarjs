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
#import "Underscore.h"

#define _ Underscore

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateUI]; // ugly, but somehow this works
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self updateUI];
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
    
    NSLog(@"%@", comments);
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
    cell.author = [self.comments[indexPath.item] objectForKey:@"username"];
    cell.created = [[self.comments[indexPath.item] objectForKey:@"ctime"] doubleValue];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *comment = [self.comments[indexPath.item] objectForKey:@"body"];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    screenSize.width -= 80.0f;
    
    CGSize size = [comment sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake([self.tableView frame].size.width - 80.0f, 2009)]; // screenSize
    size.height += 60.0f;
    
    // invert calculated size in portrait mode
//    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
//        CGFloat width = size.width;
//        size.width = size.height;
//        size.height = width;
//    }
    return size.height;
}

@end
