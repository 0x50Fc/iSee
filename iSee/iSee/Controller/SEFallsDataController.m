//
//  SEFallsDataController.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEFallsDataController.h"

@implementation SEFallsDataController


-(CGSize) vtContainerLayout:(VTContainerLayout *) containerLayout itemSizeAtIndex:(NSInteger) index{
    
    id source = [self.context focusValueForKey:@"source"];
    
    id data = [self.dataSource dataObjectAtIndex:index];
    
    CGFloat width = [[data valueForKeyPath:[source valueForKeyPath:@"data.imageWidthKey"]] floatValue];
    CGFloat height = [[data valueForKeyPath:[source valueForKeyPath:@"data.imageHeightKey"]] floatValue];
    
    CGFloat columnWidth = containerLayout.size.width / [[containerLayout valueForKey:@"numberOfColumn"] intValue];
    
    return CGSizeMake(columnWidth, columnWidth * height / width);
}

@end
