//
//  SESourceDataSource.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SESourceDataSource.h"

#import "SEContext.h"

@implementation SESourceDataSource

-(void) reloadData{
    
    [super reloadData];
    

    [self vtDownlinkTaskDidLoaded:[(id<SEContext>)self.context iSeeSources] forTaskType:nil];
}

@end
