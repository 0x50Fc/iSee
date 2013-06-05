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
    [_dataController setItemViewBundle:[source valueForKey:@"bundle"]];
    [_dataController.dataSource setDataKey:[source valueForKey:@"dataKey"]];
    [_dataController.dataSource setValue:[source valueForKey:@"checkDataKey"] forKey:@"checkDataKey"];
    
    [_dataController.dataSource setValue:[source valueForKey:@"url"] forKey:@"url"];
    
    [_dataController reloadData];
    
    self.source = source;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void) vtContainerDataController:(VTContainerDataController *) dataController itemViewController:(VTItemViewController *) itemViewController doAction:(id<IVTAction>) action{
    NSString * actionName = [action actionName];
    if([actionName isEqualToString:@"image"]){
        
        [self.context setFocusValue:[dataController dataSource] forKey:@"dataSource"];
        [self.context setFocusValue:[NSNumber numberWithInt:[itemViewController index]] forKey:@"imageIndex"];
        
        [self openUrl:[NSURL URLWithString:@"../image" relativeToURL:self.url] animated:YES];
        
    }
}

@end
