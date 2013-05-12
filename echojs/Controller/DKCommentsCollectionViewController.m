//
//  DKCommentsCollectionViewController.m
//  echojs
//
//  Created by Damien Klinnert on 12.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKCommentsCollectionViewController.h"
#import "AFNetworking.h"
#import "DKCommentCollectionViewCell.h"

@interface DKCommentsCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation DKCommentsCollectionViewController

#pragma mark - Properties

- (void)setArticleId:(NSInteger)articleId
{
    _articleId = articleId;
    [self updateUI];
}

- (void)setData:(NSMutableArray *)data
{
    _data = data;
    [self updateUI];
}

#pragma mark - Rendering

- (void)updateUI
{
    // complete reload, should be changed later to higher performance
    [self.collectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
    [self updateUI];
}

#pragma mark - Actions

- (IBAction)loadData
{
//    [self.refreshControl beginRefreshing];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_queue_t q = dispatch_queue_create("comments", NULL); // serial
    dispatch_async(q, ^{
        
        NSString *urlString = [NSString stringWithFormat:@"http://www.echojs.com/api/getcomments/%d",
                               self.articleId];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // this will update the ui, so we need to call it here!!
                self.data = [JSON valueForKeyPath:@"comments"];
                
                // all ui kit related code most go here, because it is NOT threadsave
//                [self.refreshControl endRefreshing];
                
                // this spinner is global so basically we would need a kind of reference counting
                // whether things are going right now or not!
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        } failure:nil];
        
        [operation start];
    });
}

#pragma mark - Data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DKCommentCollectionViewCell *cell = (DKCommentCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"Comment" forIndexPath:(NSIndexPath*)indexPath];
    
    // configure cell
    cell.comment = [self.data[indexPath.item] objectForKey:@"body"];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.data count];
}

@end
