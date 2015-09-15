//
//  NVLoginVC.h
//  45. APIWithoutAccessToken
//
//  Created by Admin on 28.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NVUser;
@class NVAccessToken;
typedef void(^NVCompletionBlock)(NVAccessToken* accessToken);

@interface NVLoginVC : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (copy,nonatomic) NVCompletionBlock completionBlock;
- (IBAction)actionClose:(UIBarButtonItem *)sender;


- (instancetype)initWithCompletionBlock:(NVCompletionBlock) completionBlock;
@end
