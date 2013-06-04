//
//  SEHomeViewController.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEHomeViewController.h"

#import "SEContext.h"

@interface SEHomeViewController ()

@property(nonatomic,retain) id source;

@end

@implementation SEHomeViewController

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
 
    [_dataController setContext:self.context];
    
    
    id source = [self.context focusValueForKey:@"source"];
    
    [_dataController setItemViewClass:[source valueForKey:@"itemViewClass"]];
    [_dataController setItemViewNib:[source valueForKey:@"itemViewNib"]];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

@end
