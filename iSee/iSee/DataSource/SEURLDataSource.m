//
//  SEURLDataSource.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEURLDataSource.h"

@implementation SEURLDataSource

-(id) init{
    if((self = [super init])){
        [self setPageSize:50];
    }
    return self;
}

-(void) dealloc{
    
    [self.context cancelHandle:@protocol(SEURLTask) task:self];

}

-(NSString *) URLTaskURL{
    return _url;
}

-(BOOL) URLTaskFromCached{
    return _fromCached;
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

-(void) loadResultsData:(id)resultsData{
   
    NSArray * items = self.dataKey ? [resultsData valueForKeyPath:self.dataKey] : resultsData;
    
    if([items isKindOfClass:[NSArray class]]){
        
        if(self.checkDataKey){
            
            NSMutableArray * dataObjects = [self dataObjects];
            
            for(id item in items){
                if([item valueForKeyPath:self.checkDataKey]){
                    [dataObjects addObject:item];
                }
            }
        }
        else{
            [[self dataObjects] addObjectsFromArray:items];
        }
    }
    else if(items){
        [[self dataObjects] addObject:items];
    }
}

@end
