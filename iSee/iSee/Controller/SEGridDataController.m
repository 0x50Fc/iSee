//
//  SEGridDataController.m
//  iSee
//
//  Created by zhang hailong on 13-6-4.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEGridDataController.h"

@interface SEGridDataController(){
    NSInteger _columnIndex;
    NSInteger _columnCount;
}

@end

@implementation SEGridDataController

-(NSInteger) numberOfVTContainerLayout:(VTContainerLayout *) containerLayout{
    _columnIndex = 0;
    _columnCount = containerLayout.size.width > containerLayout.size.height ? 4 : 3;
    return [super numberOfVTContainerLayout:containerLayout];
}

-(CGSize) vtContainerLayout:(VTContainerLayout *) containerLayout itemSizeAtIndex:(NSInteger) index{
    
    id source = [self.context focusValueForKey:@"source"];
    
    id data = [self.dataSource dataObjectAtIndex:index];
    
    CGFloat width = [[data valueForKeyPath:[source valueForKeyPath:@"imageWidthKey"]] floatValue];
    CGFloat height = [[data valueForKeyPath:[source valueForKeyPath:@"imageHeightKey"]] floatValue];
    
    CGFloat columnWidth = containerLayout.size.width / _columnCount;
    
    if(width > height){
        if(_columnIndex < _columnCount - 1){
            _columnIndex = ( _columnIndex + 2 ) % _columnCount;
            return CGSizeMake(columnWidth * 2, 160);
        }
    }
    
    _columnIndex = ( _columnIndex + 1 ) % _columnCount;
    
    return CGSizeMake(columnWidth, 160);
}

@end
