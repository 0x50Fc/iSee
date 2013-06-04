//
//  SEURLDataSource.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEURLDataSource.h"

@implementation SEURLDataSource

-(void) dealloc{
    
    [self.context cancelHandle:@protocol(SEURLTask) task:self];

}

-(NSString *) URLTaskURL{
    return _url;
}

-(void) reloadData{
    [super reloadData];
    
    [self.context handle:@protocol(SEURLTask) task:self priority:0];
}

-(void) loadMoreData{
    [super loadMoreData];
    
    [self.context handle:@protocol(SEURLTask) task:self priority:0];
}

-(void) cancel{
    [super cancel];
    
    [self.context cancelHandle:@protocol(SEURLTask) task:self];
}


@end
