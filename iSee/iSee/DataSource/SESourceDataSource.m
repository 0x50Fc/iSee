//
//  SESourceDataSource.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SESourceDataSource.h"

@implementation SESourceDataSource

-(void) reloadData{
    
    [super reloadData];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSMutableArray * dataObjects = [NSMutableArray arrayWithCapacity:4];
    
    NSString * dir = [[NSBundle mainBundle] resourcePath];
    
    NSDirectoryEnumerator * dirEnum = [fileManager enumeratorAtPath:dir];
    
    NSString * item ;
    
    while((item = [dirEnum nextObject])){
        
        if([item hasSuffix:@".bundle"]){
            
            NSString * itemPath = [dir stringByAppendingPathComponent:item];
            NSBundle * bundle = [NSBundle bundleWithPath:itemPath];
            
            NSArray * sources = [[bundle infoDictionary] valueForKeyPath:@"Sources"];
            
            if([sources isKindOfClass:[NSArray class]]){
                
                for(NSDictionary * source in sources){
                    NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:source];
                    [d setValue:bundle forKey:@"bundle"];
                    [dataObjects addObject:d];
                }
            }
        }
    }
    
    [self vtDownlinkTaskDidLoaded:dataObjects forTaskType:nil];
}

@end
