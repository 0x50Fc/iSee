//
//  SEImageView.m
//  iSee
//
//  Created by zhang hailong on 13-5-3.
//  Copyright (c) 2013年 hailong.org. All rights reserved.
//

#import "SEImageView.h"

#import <QuartzCore/QuartzCore.h>

@interface SEImageView(){
    UIImageView * _loadingView;
}

@end

@implementation SEImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIImageView *) loadingView{
    if(_loadingView == nil){
        _loadingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heart.png"]];
    }
    return  _loadingView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) startAnimating{
    
    if([_loadingView.layer animationForKey:@"ZoomOut"] ==  nil){
        UIView * v = [self loadingView];
        CGRect r = v.frame;
        CGSize size = self.bounds.size;
        r.origin = CGPointMake((size.width - r.size.width) / 2.0, (size.height - r.size.height) / 2.0);
        [v setFrame:r];
        [v setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
        
        if(v.superview == nil){
            [self addSubview:v];
        }
        
        CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"transform"];
        [anim setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 0.8)]];
        [anim setDuration:0.3];
        [anim setAutoreverses:YES];
        [anim setRemovedOnCompletion:NO];
        [anim setRepeatCount:MAXFLOAT];
        
        [_loadingView.layer addAnimation:anim forKey:@"ZoomOut"];

        [v.layer addAnimation:anim forKey:@"transform"];
    }
}

-(void) stopAnimating{
    UIView * v = [self loadingView];
    [v.layer removeAllAnimations];
    [v removeFromSuperview];
}

-(void) setLoaded:(BOOL)loaded{
    [super setLoaded:loaded];
    if(!loaded){
        [self startAnimating];
    }
}

-(void) setImage:(UIImage *) image isLocal:(BOOL) isLocal{
    [super setImage:image isLocal:isLocal];
    if(!isLocal){
        if([_loadingView.layer animationForKey:@"ZoomOut"] && self.defaultImage == nil){
            [self setAlpha:0.0];
            [UIView beginAnimations:@"alpha" context:nil];
            [UIView setAnimationDuration:0.3];
            [self setAlpha:1.0];
            [UIView commitAnimations];
        }
        [self stopAnimating];
    }
    else if(image){
        [self stopAnimating];
    }
}
@end
