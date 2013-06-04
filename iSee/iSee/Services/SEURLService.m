//
//  SEURLService.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEURLService.h"

#import "SEURLTask.h"

@implementation SEURLService


-(BOOL) handle:(Protocol *)taskType task:(id<IVTTask>)task priority:(NSInteger)priority{
    
    if(taskType == @protocol(SEURLTask)){
        
        VTAPIRequestTask * reqTask = [[VTAPIRequestTask alloc] init];
        
        [reqTask setTask:task];
        [reqTask setTaskType:taskType];
        [reqTask setSource:[task source]];
        
        NSInteger pageIndex = [(id) task vtDownlinkPageTaskPageIndex];
        NSInteger pageSize = [(id) task vtDownlinkPageTaskPageSize];
        NSInteger offset = (pageIndex - 1) * pageSize;
        
        NSString * url = [(id)task URLTaskURL];
        
        url = [url stringByReplacingOccurrencesOfString:@"{offset}" withString:[NSString stringWithFormat:@"%d",offset]];
        url = [url stringByReplacingOccurrencesOfString:@"{pageIndex}" withString:[NSString stringWithFormat:@"%d",pageIndex]];
        url = [url stringByReplacingOccurrencesOfString:@"{pageSize}" withString:[NSString stringWithFormat:@"%d",pageSize]];
        
        [reqTask setApiUrl:url];

        
        [self.context handle:@protocol(IVTAPIRequestTask) task:reqTask priority:priority];
        
        if(pageIndex == 1){
            [self vtDownlinkTaskDidLoadedFromCache:(id<SEURLTask>)task forTaskType:taskType];
        }
        
        return YES;
    }
    
    if(taskType == @protocol(IVTAPIResponseTask)){
        
        id<IVTAPIResponseTask> respTask = (id<IVTAPIResponseTask>) task;
        
        if([respTask taskType] == @protocol(SEURLTask)){
            
            
            if([respTask error]){
                [self vtDownlinkTask:[respTask task] didFitalError:[respTask error] forTaskType:[respTask taskType]];
            }
            else{
                
                [self vtDownlinkTask:[respTask task] didResponse:[respTask resultsData]
                             isCache:[(id)[respTask task] vtDownlinkPageTaskPageIndex] == 1 forTaskType:[respTask taskType]];
            }
            
            NSLog(@"%@",[respTask resultsData]);
            
            return YES;
        }
        
    }
    
    return NO;
}

-(NSString *) cacheValueKey:(id<IVTDownlinkTask>)task forTaskType:(Protocol *)taskType{
    if(taskType == @protocol(SEURLTask)){
        return [(id)task URLTaskURL];
    }
    return [super cacheValueKey:task forTaskType:taskType];
}

@end
