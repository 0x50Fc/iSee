//
//  SEPhotoItemViewController.m
//  iSee
//
//  Created by Zhang Hailong on 13-5-5.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEPhotoItemViewController.h"

@interface SEPhotoItemViewController ()

@end

@implementation SEPhotoItemViewController

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
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(tapAction:)];
    
    [tapGestureRecognizer setNumberOfTapsRequired:2];
    
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setImageView:nil];
    [self setContentView:nil];
    [super viewDidUnload];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_contentView setZoomScale:1.0 animated:NO];
}

-(void) tapAction:(id) sender{
    if([_contentView zoomScale] == 1.0){
        [_contentView setZoomScale:2.0 animated:YES];
    }
    else{
        [_contentView setZoomScale:1.0 animated:YES];
    }
}

@end
