//
//  SEHomeViewController.h
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEViewController.h"

#import "SEGridDataController.h"

@interface SEHomeViewController : SEViewController

@property (strong, nonatomic) IBOutlet SEGridDataController *dataController;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
