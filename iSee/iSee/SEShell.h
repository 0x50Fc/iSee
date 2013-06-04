/**
 *  SEShell.h
 *  iSee
 *
 *  Created by zhang hailong on 13-6-4.
 *  Copyright hailong.org 2013年. All rights reserved.
 */


#import <UIKit/UIKit.h>
#import <vTeam/vTeam.h>
#import "SEContext.h"

@interface SEShell : VTShell<UIApplicationDelegate,SEContext> {
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@end
