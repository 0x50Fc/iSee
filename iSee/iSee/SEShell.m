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
    
    [WXApi registerApp:@"wx9dde4d62d324eb5e"];
    
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

-(BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}

/*! @brief 收到一个来自微信的请求，处理完后调用sendResp
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req{
    
}

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp{
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        if([resp errCode] == WXSuccess){
            VTAppStatusMessageView * appStatus = [[VTAppStatusMessageView alloc] initWithTitle:@"微信发送成功"];
            [appStatus show:YES duration:1.5];
        }
        else{
            VTAppStatusMessageView * appStatus = [[VTAppStatusMessageView alloc] initWithTitle:resp.errStr];
            [appStatus show:YES duration:1.5];
        }
    }
}



@end
