//
//  DKCommentsViewController.m
//  echojs
//
//  Created by Damien Klinnert on 12.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKCommentsViewController.h"
#import "UIApplication+NetworkActivityManager.h"

@interface DKCommentsViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *commentWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation DKCommentsViewController

#pragma mark - Setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.commentWebView.scalesPageToFit = YES;
    self.commentWebView.delegate = self;
    
    [self updateUI];
}

- (void)viewDidDisappear:(BOOL)animated
{
    if ([self isMovingFromParentViewController] && self.commentWebView.isLoading) {
        [[UIApplication sharedApplication] hideNetworkActivityIndicator];
        [self.commentWebView stopLoading];
    }
}



#pragma mark - Getters / Setters

- (void)setArticleId:(NSInteger)articleId
{
    _articleId = articleId;
    [self updateUI];
}



#pragma mark - UI

- (void)updateUI
{
    NSString *commentsUrlString = [NSString stringWithFormat:@"http://www.echojs.com/news/%d", self.articleId];
    NSURL *url = [NSURL URLWithString:commentsUrlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [self.commentWebView loadRequest:requestObj];
}



#pragma mark - webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] showNetworkActivityIndicator];
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] hideNetworkActivityIndicator];
    [self.spinner stopAnimating];
}

@end
