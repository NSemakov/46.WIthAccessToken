//
//  NVLoginVC.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVLoginVC.h"
#import "NVFriend.h"

@interface NVLoginVC ()
@property (copy,nonatomic) CompletionBlock completionBlock;
@end

@implementation NVLoginVC

- (instancetype)initWithCompletionBlock:(CompletionBlock) completionBlock
{
    self = [super init];
    if (self) {
        self.completionBlock=completionBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    UIWebView* webView=[[UIWebView alloc]init];
    NSURL* url=[NSURL URLWithString:<#(NSString *)#>];
    NSURLRequest* request=[NSURLRequest requestWithURL:<#(NSURL *)#>];
    [webView loadRequest:<#(NSURLRequest *)#>];
    
    self.webView=webView;
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
