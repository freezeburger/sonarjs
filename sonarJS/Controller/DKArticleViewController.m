//
//  DKArticleViewController.m
//  echojs
//
//  Created by Damien Klinnert on 01.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKArticleViewController.h"
#import "DKCommentsViewController.h"

@interface DKArticleViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commentsButton;
@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation DKArticleViewController

#pragma mark - Setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.articleWebView.delegate = self;
    
	[self updateUI];
}



#pragma mark - Getters / Setters

- (void)setArticleTitle:(NSString *)articleTitle
{
    _articleTitle = articleTitle;
    [self updateUI];
}

- (void)setArticleUrl:(NSString *)articleUrl
{
    _articleUrl = articleUrl;
    [self updateUI];
}

- (void)setArticleId:(NSInteger)articleId
{
    _articleId = articleId;
    [self updateUI];
}

- (void)setArticleComments:(NSInteger)articleComments
{
    _articleComments = articleComments;
    [self updateUI];
}



#pragma mark - UI

- (void)updateUI
{
    NSURL *url = [NSURL URLWithString:self.articleUrl];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.articleWebView loadRequest:requestObj];
    
    self.title = self.articleTitle;
}



#pragma mark - Event handlers

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Comments"]) {
        if ([segue.destinationViewController isKindOfClass:[DKCommentsViewController class]]) {
            DKCommentsViewController *destinationController = (DKCommentsViewController *)segue.destinationViewController;
            
            destinationController.articleId = self.articleId;
        }
    }
}



#pragma mark - webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.spinner stopAnimating];
}

@end
