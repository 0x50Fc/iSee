//
//  SEContainerViewController.h
//  iSee
//
//  Created by zhang hailong on 13-6-5.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEViewController.h"

@interface SEContainerViewController : SEViewController

@property (strong, nonatomic) IBOutlet VTContainerDataController *dataController;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
