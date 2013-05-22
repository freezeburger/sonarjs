//
//  DKArticleTableViewController.m
//  echojs
//
//  Created by Damien Klinnert on 01.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKArticleTableViewController.h"
#import "DKArticleViewController.h"
#import "DKArticleTableViewCell.h"
#import "DKEchoJS.h"
#import "UIApplication+NetworkActivityManager.h"
#import "ECSlidingViewController.h"
#import "UIScrollView+SVInfiniteScrolling.h"

#define DK_DEFAULTS_SHOWS_LATEST @"showsLatest"
#define DK_ARTICLE_START_INDEX 0
#define DK_ARTICLE_PAGE_COUNT 30

@interface DKArticleTableViewController ()
@property (strong, nonatomic) NSMutableArray *data;
@property (nonatomic) BOOL showsLatest;
@property (nonatomic) NSInteger currentPage;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@end

@implementation DKArticleTableViewController

#pragma mark - Setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureCustomUI];
    
    // load state of order toggle
    self.showsLatest = [[NSUserDefaults standardUserDefaults] boolForKey:DK_DEFAULTS_SHOWS_LATEST];
    self.orderButton.selected = self.showsLatest;
    
    // ios bug: we have to chain the target / action in code
    [self.refreshControl addTarget:self action:@selector(handlePullToRefresh:) forControlEvents:UIControlEventValueChanged];
    
    // add infinite scrolling
    __weak DKArticleTableViewController *weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf handleInfiniteScroll:nil];
    }];
    
    // add side menu
    self.slidingViewController.underLeftViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Menu"];
    
    self.currentPage = 0;

    
    // initially load data
    [self handleRefreshButton:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // set side menu position
    self.slidingViewController.anchorRightRevealAmount = 280.0f;

    [self animateToolbarDisappear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self animateToolbarAppear];
}



#pragma mark - Getters / Setters

- (void)setData:(NSMutableArray *)data
{
    _data = data;
    [self updateUI];
}

- (void)setShowsLatest:(BOOL)showsLatest
{
    [[NSUserDefaults standardUserDefaults] setBool:showsLatest forKey:DK_DEFAULTS_SHOWS_LATEST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _showsLatest = showsLatest;
}



#pragma mark - UI

- (void)configureCustomUI
{
    [self.tableView setContentInset:UIEdgeInsetsMake(10,0,10,0)];
}

- (void)updateUI
{
    [self.tableView reloadData]; // change to partial reload for higher performance
}

- (void)animateToolbarAppear
{
    self.navigationController.toolbarHidden = NO;
}

- (void)animateToolbarDisappear
{
    self.navigationController.toolbarHidden = YES;
}



#pragma mark - Event handlers

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(DKArticleTableViewCell *)sender
{
    if ([segue.identifier isEqualToString:@"Show Article"]) {
        if ([segue.destinationViewController isKindOfClass:[DKArticleViewController class]]) {
            DKArticleViewController *destinationController = (DKArticleViewController *)segue.destinationViewController;
            
            NSIndexPath *selectedRowindexPath = [super.tableView indexPathForSelectedRow];
            
            destinationController.articleTitle = [self.data[selectedRowindexPath.row] objectForKey:@"title"];
            destinationController.articleUrl = [self.data[selectedRowindexPath.row] objectForKey:@"url"];
            destinationController.articleId = [[self.data[selectedRowindexPath.row] objectForKey:@"id"] integerValue];
            destinationController.articleComments = [[self.data[selectedRowindexPath.row] objectForKey:@"comments"] integerValue];
        }
    }
}

- (IBAction)handleRefreshButton:(id)sender {
    
    self.currentPage = 0;
    
    [[UIApplication sharedApplication] showNetworkActivityIndicator];
    [self.refreshControl beginRefreshing];
    [self.tableView scrollRectToVisible:self.refreshControl.frame animated:NO];
    
    [[DKEchoJS sharedInstance] retrieveArticlesOrderedBy:(self.showsLatest ? DKEchoJSOrderModeLatest :  DKEchoJSOrderModeTop) startingAtIndex:DK_ARTICLE_START_INDEX withCount:DK_ARTICLE_PAGE_COUNT success:^(id articles){
        self.data = [articles mutableCopy]; // this will update the ui, so we need to call it here!!

        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        [self.refreshControl endRefreshing];
        [[UIApplication sharedApplication] hideNetworkActivityIndicator];
    }];

}

- (IBAction)handlePullToRefresh:(id)sender
{
    self.currentPage = 0;

    [[UIApplication sharedApplication] showNetworkActivityIndicator];
    [self.refreshControl beginRefreshing];
    [self.tableView scrollRectToVisible:self.refreshControl.frame animated:NO];
    
    [[DKEchoJS sharedInstance] retrieveArticlesOrderedBy:(self.showsLatest ? DKEchoJSOrderModeLatest :  DKEchoJSOrderModeTop) startingAtIndex:DK_ARTICLE_START_INDEX withCount:DK_ARTICLE_PAGE_COUNT success:^(id articles){
        self.data = [articles mutableCopy]; // this will update the ui, so we need to call it here!!
        
        [self.refreshControl endRefreshing];
        [[UIApplication sharedApplication] hideNetworkActivityIndicator];
    }];
}

- (IBAction)handleInfiniteScroll:(id)sender
{
    [[UIApplication sharedApplication] showNetworkActivityIndicator];

    self.currentPage += 1;
    [[DKEchoJS sharedInstance] retrieveArticlesOrderedBy:(self.showsLatest ? DKEchoJSOrderModeLatest :  DKEchoJSOrderModeTop) startingAtIndex:self.currentPage * DK_ARTICLE_PAGE_COUNT withCount:DK_ARTICLE_PAGE_COUNT success:^(id JSON){
        
        [self.data addObjectsFromArray:JSON];
        [self updateUI];
        
        [self.tableView.infiniteScrollingView stopAnimating];
        [[UIApplication sharedApplication] hideNetworkActivityIndicator];
    }];

}

- (IBAction)handleMenuButton:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)handleOrderButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.showsLatest = sender.selected;
    self.data = nil;
    [self handleRefreshButton:nil];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Article";
    DKArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
    cell.articleTitle = [self.data[indexPath.item] objectForKey:@"title"];
    cell.articleUrl = [self.data[indexPath.item] objectForKey:@"url"];
    cell.articleUpvotes = [[self.data[indexPath.item] objectForKey:@"up"] integerValue];
    cell.articleDownvotes = [[self.data[indexPath.item] objectForKey:@"down"] integerValue];
    cell.articleComments = [[self.data[indexPath.item] objectForKey:@"comments"] integerValue];
    cell.articleCreated = [[self.data[indexPath.item] objectForKey:@"ctime"] integerValue];
    
    return cell;
}

@end