//
//  SEContainerViewController.m
//  iSee
//
//  Created by zhang hailong on 13-6-5.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEContainerViewController.h"

@interface SEContainerViewController ()

@property(nonatomic,retain) id source;

-(void) resetSource:(id) source;

@end

@implementation SEContainerViewController

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
	// Do any additional setup after loading the view.
    
    [_dataController setContext:self.context];
    
    id source = [self.context focusValueForKey:@"source"];
    
    [self resetSource:source];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) resetSource:(id) source{
    
    [_dataController setItemViewClass:[source valueForKeyPath:@"home.itemViewClass"]];
    [_dataController setItemViewNib:[source valueForKeyPath:@"home.itemViewNib"]];
    [_dataController setItemViewBundle:[source valueForKey:@"bundle"]];
    [_dataController.dataSource setDataKey:[source valueForKeyPath:@"data.dataKey"]];
    [_dataController.dataSource setValue:[source valueForKeyPath:@"data.checkDataKey"] forKey:@"checkDataKey"];
    
    [_dataController.dataSource setValue:[source valueForKeyPath:@"data.url"] forKey:@"url"];
    [[_dataController.dataSource dataObjects] removeAllObjects];
    
    [_dataController reloadData];
    
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
    
    [_titleLabel setText:[source valueForKey:@"title"]];
    
    self.source = source;
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    id dataSource = [self.context focusValueForKey:@"dataSource"];
    
    if(dataSource){
        [dataSource setDelegate:_dataController];
        [_dataController setDataSource:dataSource];
        
        [self.context setFocusValue:nil forKey:@"dataSource"];
        
        
        NSInteger index = [[self.context focusValueForKey:@"imageIndex"] intValue];
        
        [_dataController.containerView setFocusIndex:index animated:NO];
    }
    else{
        [_dataController.containerView setFocusIndex:0 animated:NO];
    }
}

-(void) vtContainerDataController:(VTContainerDataController *) dataController itemViewController:(VTItemViewController *) itemViewController doAction:(id<IVTAction>) action{
    NSString * actionName = [action actionName];
    if([actionName isEqualToString:@"url"]){
        
        [self.context setFocusValue:[dataController dataSource] forKey:@"dataSource"];
        [self.context setFocusValue:[NSNumber numberWithInt:[itemViewController index]] forKey:@"imageIndex"];

        [self openUrl:[NSURL URLWithString:[[action userInfo] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] relativeToURL:self.url] animated:YES];
        
    }
}

-(void) receiveUrl:(NSURL *)url source:(id)source{
    
    id s = [self.context focusValueForKey:@"source"];
    
    if(s != self.source){
        
        [_dataController cancel];
        [_dataController.containerView setFocusIndex:0 animated:NO];

        [self resetSource:s];
        
    }
    
    [super receiveUrl:url source:source];
}

@end
