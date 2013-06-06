//
//  SEBrowserViewController.m
//  iSee
//
//  Created by zhang hailong on 13-6-6.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEBrowserViewController.h"

@interface SEBrowserViewController ()

@end

@implementation SEBrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    id source = [self.context focusValueForKey:@"source"];
    
    id toolbar = [source valueForKey:@"toolbar"];
    
    if(toolbar){
        id v = [toolbar valueForKey:@"tintColor"];
        if(v){
            NSInteger r=0,g=0,b=0;
            
            sscanf([v UTF8String], "#%02x%02x%02x",&r,&g,&b);
            
            [_toolbar setTintColor:[UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]];
        }
        
        v = [toolbar valueForKey:@"titleColor"];
        if(v){
            NSInteger r=0,g=0,b=0;
            
            sscanf([v UTF8String], "#%02x%02x%02x",&r,&g,&b);
            
            [_titleLabel setTextColor:[UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]];
        }
    }
    
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSDictionary * value = [self.url queryValues];
    
    self.title = [value valueForKey:@"title"];
    
    [_titleLabel setText:@"加载中..."];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[value valueForKey:@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [_webView loadHTMLString:@"" baseURL:nil];
}


-(void) webViewDidFinishLoad:(UIWebView *)webView{
    if(self.title){
        [_titleLabel setText:self.title];
    }
    else{
        [_titleLabel setText:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    }
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if(![webView isLoading]){
        [_titleLabel setText:@"加载出错了 :( "];
    }
}



@end
