/**
 *  SEShell.m
 *  iSee
 *
 *  Created by zhang hailong on 13-6-4.
 *  Copyright hailong.org 2013年. All rights reserved.
 */

#import "SEShell.h"

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

@end
