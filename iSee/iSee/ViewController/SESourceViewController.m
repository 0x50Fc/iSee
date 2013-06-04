//
//  SESourceViewController.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SESourceViewController.h"

@interface SESourceViewController ()

@end

@implementation SESourceViewController

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
    
    [_dataController reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) vtContainerDataController:(VTContainerDataController *) dataController itemViewController:(VTItemViewController *) itemViewController doAction:(id<IVTAction>) action{
    
    [self.context setFocusValue:itemViewController.dataItem forKey:@"source"];
    
    [self openUrl:[NSURL URLWithString:@"fold:///center"] animated:YES];
    
}

@end
