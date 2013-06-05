//
//  SEPhotoItemViewController.h
//  iSee
//
//  Created by Zhang Hailong on 13-5-5.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import <vTeam/vTeam.h>
#import "SEImageView.h"

@interface SEPhotoItemViewController : VTItemViewController<UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet SEImageView *imageView;
@property (retain, nonatomic) IBOutlet UIScrollView *contentView;

@end
