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
#import "AFNetworking.h"
#import "UINavigationBar+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"

@interface DKArticleTableViewController ()
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation DKArticleTableViewController

#pragma mark - Setup

- (void)viewDidLoad
{
    [super viewDidLoad];

    // bug: we have to chain the target / action in code
    [self.refreshControl addTarget:self
                            action:@selector(loadData)
                  forControlEvents:UIControlEventValueChanged];
    
    [self loadData];
    
    [self configureFlatUI];
    [self updateUI];
}

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

#pragma mark - Helper

- (void)configureFlatUI
{
    UIColor *redColor  = [UIColor colorWithRed:0.73f green:0.09f blue:0.00f alpha:1.00f];
    UIColor *flatDark  = [UIColor colorWithRed:0.75f green:0.22f blue:0.17f alpha:1.00f];
    UIColor *flatLight = [UIColor colorWithRed:0.91f green:0.30f blue:0.24f alpha:1.00f];
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:redColor];
    [UIBarButtonItem configureFlatButtonsWithColor:flatDark
                                  highlightedColor:flatLight
                                      cornerRadius:3];
}

- (void)updateUI
{    
    // complete reload, should be changed later to higher performance
    [self.tableView reloadData];
}

- (void)setData:(NSMutableArray *)data
{
    _data = data;
    [self updateUI];
}

#pragma mark - Actions

- (IBAction)loadData
{
    [self.refreshControl beginRefreshing];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_queue_t q = dispatch_queue_create("articles", NULL); // serial
    dispatch_async(q, ^{
        
        NSURL *url = [NSURL URLWithString:@"http://www.echojs.com/api/getnews/top/0/30"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            dispatch_async(dispatch_get_main_queue(), ^{

                // this will update the ui, so we need to call it here!!
                self.data = [JSON valueForKeyPath:@"news"];

                // all ui kit related code most go here, because it is NOT threadsave
                [self.refreshControl endRefreshing];
                
                // this spinner is global so basically we would need a kind of reference counting
                // whether things are going right now or not!
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        } failure:nil];
        
        [operation start];
    });
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
