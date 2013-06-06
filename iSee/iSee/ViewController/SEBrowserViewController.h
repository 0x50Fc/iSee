//
//  SEBrowserViewController.h
//  iSee
//
//  Created by zhang hailong on 13-6-6.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEViewController.h"

@interface SEBrowserViewController : SEViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
