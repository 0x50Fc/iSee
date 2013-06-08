//
//  SEURLTask.h
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <vTeam/vTeam.h>

@protocol SEURLTask <IVTDownlinkPageTask>

-(NSString *) URLTaskURL;

-(BOOL) URLTaskFromCached;

@end
