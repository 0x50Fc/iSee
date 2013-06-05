/**
 *  SEShell.m
 *  iSee
 *
 *  Created by zhang hailong on 13-6-4.
 *  Copyright hailong.org 2013年. All rights reserved.
 */

#import "SEShell.h"

@interface SEShell(){
    NSMutableArray * _iSeeSources;
}

@end

@implementation SEShell


-(id) init{
    if((self = [super initWithConfig:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cfg" ofType:@"plist"]] bundle:nil])){
        
    }
    return self;
}

-(BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    NSLog(@"%@",NSHomeDirectory());
    
    [_window setRootViewController:self.rootViewController];
    [_window makeKeyAndVisible];
    
    return YES;
}

-(void) applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [self didReceiveMemoryWarning];
}

-(void) applicationDidEnterBackground:(UIApplication *)application{
    [self didReceiveMemoryWarning];
}

-(NSArray *) iSeeSources{
    
    if(_iSeeSources == nil){
        
        _iSeeSources = [[NSMutableArray alloc] initWithCapacity:4];
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        
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
                        [_iSeeSources addObject:d];
                    }
                }
            }
        }
        
        if([_iSeeSources count] >0){
            [self setFocusValue:[_iSeeSources objectAtIndex:0] forKey:@"source"];
        }
    }
    return _iSeeSources;
}

-(id) focusValueForKey:(NSString *)key{
    if([key isEqualToString:@"source"]){
        if(_iSeeSources == nil){
            [self iSeeSources];
        }
    }
    return [super focusValueForKey:key];
}

@end
