//
//  BTRippleButtton.m
//  BTSimpleRippleButton
//
//  Created by Balram Tiwari on 01/06/14.
//  Copyright (c) 2014 Balram. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "BTRippleButtton.h"

@implementation BTRippleButtton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)commonInitWithView:(UIView *)view andFrame:(CGRect) frame{
    
    mainView = view;
    mainView.frame = CGRectMake(0, 0, frame.size.width-5, frame.size.height-5);
    mainView.layer.borderColor = [UIColor clearColor].CGColor;
    mainView.layer.borderWidth = 3;
    mainView.clipsToBounds = YES;
    mainView.layer.cornerRadius = mainView.frame.size.height/2;
    [self addSubview:mainView];
    
    mainView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.borderWidth = 5;
    self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.9].CGColor;
    
    gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:gesture];
    
}
-(void)commonInitWithButton:(UIButton *)button andFrame:(CGRect) frame{
    
    [button addTarget:self action:@selector(handleTap:) forControlEvents:UIControlEventTouchUpInside];
    mainView = button;
    mainView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self addSubview:mainView];
    
}

-(instancetype)initWithView:(UIView *)view
                    andFrame:(CGRect)frame
                   andTarget:(SEL)action
                       andID:(id)sender {
    self = [super initWithFrame:frame];
    
    if(self){
        [self commonInitWithView:view andFrame:frame];
        methodName = action;
        superSender = sender;
    }
    
    return self;
}

-(instancetype)initWithButton:(UIButton *) button
                   andFrame:(CGRect)frame
                  andTarget:(SEL)action
                      andID:(id)sender {
    self = [super initWithFrame:frame];
    
    if(self){
        [self commonInitWithButton:button andFrame:frame];
        methodName = action;
        superSender = sender;
    }
    
    return self;
}

-(instancetype)initWithView:(UIView *)view andFrame:(CGRect)frame onCompletion:(completion)completionBlock {
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self commonInitWithView:view andFrame:frame];
        self.block = completionBlock;
    }
    
    return self;
}


-(void)setRippleEffectWithColor:(UIColor *)color {
    rippleColor = color;
}

-(void)setRippeEffectEnabled:(BOOL)enabled {
    isRippleOn = enabled;
}

-(void)handleTap:(id)sender {

    if (isRippleOn) {
        UIColor *stroke = rippleColor ? rippleColor : [UIColor colorWithWhite:0.8 alpha:0.8];
        
        CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
        
        // accounts for left/right offset and contentOffset of scroll view
        CGPoint shapePosition = [self convertPoint:self.center fromView:nil];
        
        CAShapeLayer *circleShape = [CAShapeLayer layer];
        circleShape.path = path.CGPath;
        circleShape.position = shapePosition;
        circleShape.fillColor = [UIColor clearColor].CGColor;
        circleShape.opacity = 0;
        circleShape.strokeColor = stroke.CGColor;
        circleShape.lineWidth = 3;
        
        [self.layer addSublayer:circleShape];
        
        
        [CATransaction begin];
        //remove layer after animation completed
        [CATransaction setCompletionBlock:^{
            [circleShape removeFromSuperlayer];
        }];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.fromValue = @1;
        alphaAnimation.toValue = @0;
        
        CAAnimationGroup *animation = [CAAnimationGroup animation];
        animation.animations = @[scaleAnimation, alphaAnimation];
        animation.duration = 0.5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [circleShape addAnimation:animation forKey:nil];
        
        [CATransaction commit];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        mainView.alpha = 0.4;
        self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.9].CGColor;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            mainView.alpha = 1;
            self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.9].CGColor;
        }completion:^(BOOL finished) {
            if([superSender respondsToSelector:methodName]){
                [superSender performSelectorOnMainThread:methodName withObject:nil waitUntilDone:NO];
            }
            
            if(_block) {
                BOOL success= YES;
                _block(success);
            }
        }];
        
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



@end
