//
//  SEImageViewController.h
//  iSee
//
//  Created by zhang hailong on 13-5-3.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import <vTeam/vTeam.h>

#import "SEImageView.h"
#import <iSocial/iSocial.h>

@interface SEImageViewController : VTViewController<VTPageDataControllerDelegate,UIGestureRecognizerDelegate>

@property (retain, nonatomic) IBOutlet iSocialController *shareController;
@property (retain, nonatomic) IBOutlet VTPageDataController *dataController;
@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *playButtonItem;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *pauseButtonItem;

- (IBAction)doBackAction:(id)sender;

- (IBAction)doAction:(id)sender;

- (IBAction)doPlayAction:(id)sender;

- (IBAction)doPauseAction:(id)sender;

@end
