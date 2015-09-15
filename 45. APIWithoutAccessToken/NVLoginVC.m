//
//  NVLoginVC.m
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NVLoginVC.h"
#import "NVUser.h"
#import "NVAccessToken.h"



@interface NVLoginVC ()

@end



@implementation NVLoginVC

- (IBAction)actionClose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (instancetype)initWithCompletionBlock:(NVCompletionBlock) completion
{
    self = [super init];
    if (self) {
        self.completionBlock=completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSString* string=
    @"https://oauth.vk.com/authorize?"
                "client_id=4660160&"
                "display=mobile&"
                "redirect_uri=https://oauth.vk.com/blank.html&"
                "scope=notify,friends,photos,audio,video,docs,notes,pages,status,wall,groups,messages,email&"
                "response_type=token&"
                "v=5.37&"
                "revoke=1";
    
    NSURL* url=[NSURL URLWithString:string];

    
    NSURLRequest* request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"request %@",[[request URL] absoluteString]);
    if ([[[request URL]path] containsString:@"blank.html"]) {
        NVAccessToken* accessToken=[[NVAccessToken alloc]init];
        accessToken.accessToken=[self stringWithRegExTemplateToSearch:@"access_token" inStringToSearch:[[request URL] absoluteString]];
        accessToken.expiresIn=[self stringWithRegExTemplateToSearch:@"expires_in" inStringToSearch:[[request URL] absoluteString]];
        accessToken.userId=[self stringWithRegExTemplateToSearch:@"user_id" inStringToSearch:[[request URL] absoluteString]];
        self.webView.delegate=nil;
        if (self.completionBlock) {
            self.completionBlock(accessToken);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    /*ps://oauth.vk.com/blank.html#access_token=846ad171563a354d90fd41ad3f7f9c6e7e683cf668e2b8efa78d265fd8cde368a414ec576f2785ca2e255&expires_in=86400&user_id=1814388&email=lanfren2@gmail.com
    */
    return YES;
}
- (NSString*) stringWithRegExTemplateToSearch:(NSString*) searchString inStringToSearch:(NSString*)stringToSearch{
    NSString* pattern=[NSString stringWithFormat:@"%@=[^&]*",searchString];
    NSRegularExpression* regEx=[[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult* checkingResult=[regEx firstMatchInString:stringToSearch options:0 range:NSMakeRange(0, [stringToSearch length])];
    NSRange range=[checkingResult rangeAtIndex:0];
    NSString* string=[stringToSearch substringWithRange:range]; //access_token=234324
    NSArray* array=[string componentsSeparatedByString:@"="];
    return [array lastObject];

}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

@end
