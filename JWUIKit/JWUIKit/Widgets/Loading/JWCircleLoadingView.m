//
//  JWCircleLoadingView.m
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWCircleLoadingView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWCircleLoadingView {
    CAShapeLayer *_circleLayer;
}

JWUIKitInitialze {
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.lineWidth = 2.0f;
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.strokeEnd = 0;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:_circleLayer];
    
    self.tintColor = [UIColor redColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutLayers];
}

#pragma mark - JWLoadingViewProtocol
- (void)startAnimating {
    if (!_isAnimating) {
        _isAnimating = YES;
        
        [CATransaction begin];
        
        NSTimeInterval duration = 1.5f;
        
        CAKeyframeAnimation *strokeStartAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.duration = duration;
        strokeStartAnimation.values = @[@(0), @(0.2), @(1.0f)];
        strokeStartAnimation.keyTimes = @[@(0), @(0.5f), @(1.0f)];
        
        CAKeyframeAnimation *strokeEndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.duration = duration;
        strokeEndAnimation.values = @[@(0), @(0.9f), @(1.0f)];
        strokeEndAnimation.keyTimes = @[@(0), @(0.5f), @(1.0f)];
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup new];
        groupAnimation.animations = @[strokeStartAnimation, strokeEndAnimation];
        groupAnimation.duration = duration;
        groupAnimation.repeatCount = INFINITY;
        
        [_circleLayer addAnimation:groupAnimation forKey:nil];
        [CATransaction commit];
    }
}

- (void)stopAnimating {
    if (_isAnimating) {
        [_circleLayer removeAllAnimations];
        _isAnimating = NO;
    }
}

#pragma mark - Setter & Getter
- (void)setTintColor:(UIColor *)tintColor {
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
        _circleLayer.strokeColor = _tintColor.CGColor;
    }
}

#pragma mark - Private
- (void)layoutLayers {
    _circleLayer.frame = self.bounds;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat radius = (MIN(self.w, self.h) - _circleLayer.lineWidth) * .5f;
    CGPathAddArc(path, NULL, self.w * .5f, self.h * .5f, radius, -M_PI_2, -M_PI_2 + M_PI * 2, 0);
    _circleLayer.path = path;
    CGPathRelease(path);
}

@end
