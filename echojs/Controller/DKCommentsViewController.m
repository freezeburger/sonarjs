//
//  DKCommentsViewController.m
//  echojs
//
//  Created by Damien Klinnert on 12.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKCommentsViewController.h"

@interface DKCommentsViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation DKCommentsViewController

#pragma mark - Setters

- (void)setArticleId:(NSInteger)articleId
{
    _articleId = articleId;
    [self updateUI];
}

#pragma mark - Rendering

- (void)updateUI
{
    NSString *commentsUrlString = [NSString stringWithFormat:@"http://www.echojs.com/news/%d", self.articleId];
    NSURL *url = [NSURL URLWithString:commentsUrlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:requestObj];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    [self updateUI];
}

#pragma mark - Webview delegate

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
