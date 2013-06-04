//
//  SESourceViewController.h
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEViewController.h"

#import "SESourceDataController.h"

@interface SESourceViewController : SEViewController<VTContainerDataControllerDelegate>

@property (strong, nonatomic) IBOutlet SESourceDataController *dataController;

@end
