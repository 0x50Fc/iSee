//
//  SEImageViewController.m
//  iSee
//
//  Created by zhang hailong on 13-5-3.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEImageViewController.h"


@interface SEImageViewController ()

@end

@implementation SEImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_dataController setContext:self.context];
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [_dataController.containerView addGestureRecognizer:tapGestureRecognizer];
    
    id source = [self.context focusValueForKey:@"source"];
    
    [_dataController setItemViewClass:[source valueForKey:@"detailItemViewClass"]];
    [_dataController setItemViewNib:[source valueForKey:@"detailItemViewNib"]];
    [_dataController setItemViewBundle:[source valueForKey:@"bundle"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doBackAction:(id)sender {
    [self openUrl:[NSURL URLWithString:@"./" relativeToURL:self.url] animated:YES];
}



- (IBAction)doAction:(id)sender {
    
    VTItemViewController * itemViewController = [_dataController.containerView itemViewControllerAtIndex:[_dataController.containerView focusIndex]];
    
    UIImageView * imageView = (UIImageView *)[[itemViewController view] viewWithTag:100];
    
    if([imageView image]){
        
        
        [_shareController setImage:[imageView image]];
        
        [_shareController.actionSheet showFromBarButtonItem:sender animated:YES];
        
    }
    else{
        
        VTAppStatusMessageView * appStatus = [[VTAppStatusMessageView alloc] initWithTitle:@"无法保存图片，还没有下载成功"];
        [appStatus show:YES duration:1.5];
        
    }
    
}

-(void) nextItemAction {
    NSInteger focusIndex = [_dataController.containerView focusIndex];
    if(focusIndex != NSNotFound && focusIndex +1 <[(id)self.dataController.dataSource count] ){
        if(focusIndex +2 == [(id)self.dataController.dataSource count]){
            [(id)self.dataController.dataSource loadMoreData];
        }
        [_dataController.containerView setFocusIndex:focusIndex + 1 animated:YES];
        [self performSelector:@selector(nextItemAction) withObject:nil afterDelay:3.0];
    }
    else if([(id)self.dataController.dataSource hasMoreData]){
        [self performSelector:@selector(nextItemAction) withObject:nil afterDelay:3.0];
    }
}

- (IBAction)doPlayAction:(id)sender {
    NSMutableArray * items = [NSMutableArray arrayWithArray:[_toolbar items]];
    
    [items removeObject:_playButtonItem];
    [items removeObject:_pauseButtonItem];
    
    [items insertObject:_pauseButtonItem atIndex:2];
    
    [_toolbar setItems:items animated:YES];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextItemAction) object:nil];
    [self performSelector:@selector(nextItemAction) withObject:nil afterDelay:3.0];
    
    [_toolbar setHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (IBAction)doPauseAction:(id)sender {

    NSMutableArray * items = [NSMutableArray arrayWithArray:[_toolbar items]];
    
    [items removeObject:_playButtonItem];
    [items removeObject:_pauseButtonItem];
    
    [items insertObject:_playButtonItem atIndex:2];
    
    [_toolbar setItems:items animated:YES];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextItemAction) object:nil];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    id dataSource = [self.context focusValueForKey:@"dataSource"];
    
    [dataSource setDelegate:_dataController];
    [_dataController setDataSource:dataSource];
    
    [_dataController.containerView reloadData];
    
    [_dataController stopLoading];
    
    [_dataController.containerView setFocusIndex:[[self.context focusValueForKey:@"imageIndex"] intValue]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    
    NSMutableArray * items = [NSMutableArray arrayWithArray:[_toolbar items]];
    
    [items removeObject:_playButtonItem];
    [items removeObject:_pauseButtonItem];
    
    [items insertObject:_playButtonItem atIndex:2];
    
    [_toolbar setItems:items animated:YES];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_toolbar setHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    id dataSource = [self.context focusValueForKey:@"dataSource"];
    [_dataController cancel];
    [dataSource setDelegate:nil];
    [_dataController setDataSource:nil];
    [self.context setFocusValue:[NSNumber numberWithInt:[_dataController.containerView focusIndex]] forKey:@"imageIndex"];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextItemAction) object:nil];
    
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
}

- (void)viewDidUnload {
    [self setDataController:nil];
    [self setToolbar:nil];
    [self setShareController:nil];
    [self setPlayButtonItem:nil];
    [self setPauseButtonItem:nil];
    [super viewDidUnload];
}

-(void) vtPageDataControllerLeftAction:(VTPageDataController *)dataController{
    [self doBackAction:nil];
}

-(void) vtPageDataControllerRightAction:(VTPageDataController *)dataController{
    [(id)_dataController.dataSource loadMoreData];
}

-(BOOL) vtPageDataControllerShowLeftLoading:(VTPageDataController *) dataController{
    return YES;
}

-(BOOL) vtPageDataControllerShowRightLoading:(VTPageDataController *) dataController{
    return [(id)self.dataController.dataSource hasMoreData];
}

-(void) vtPageDataController:(VTPageDataController *)dataController focusIndexChanged:(NSInteger) focusIndex{
    if(focusIndex +1 == [(id)self.dataController.dataSource count] && [(id)self.dataController.dataSource hasMoreData]){
        [(id)_dataController.dataSource loadMoreData];
    }
    if(! [_toolbar isHidden]){
        [_toolbar setHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
}

-(void) tapAction:(id) sender{
    BOOL hidden = ![_toolbar isHidden];
    [_toolbar setHidden:hidden animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationFade];
}

@end
