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
    CALayer *_gradientLayer;
}

- (void)setup {
    [super setup];
    self.lineWidth = 3.0f;
    self.backgroundColor = [UIColor clearColor];
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.strokeEnd = 0;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = self.tintColor.CGColor;
    _circleLayer.lineWidth = self.lineWidth;
    [self.layer addSublayer:_circleLayer];
    
    self.drawBackground = YES;
    self.style = JWCircleLoadingStyleDefault;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutLayers];
}

- (void)tintColorDidChange {
    _circleLayer.strokeColor = self.tintColor.CGColor;
    if (_gradientLayer) {
        [self setGradientLayerColor];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.drawBackground && self.style != JWCircleLoadingStyleGradient) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, self.lineWidth);
        
        CGContextSetStrokeColorWithColor(context, [self.tintColor colorWithAlphaComponent:0.2].CGColor);
        CGContextBeginPath(context);
        CGContextAddPath(context, _circleLayer.path);
        CGContextStrokePath(context);
    }
}

#pragma mark - Setter & Getter
- (void)setStyle:(JWCircleLoadingStyle)style {
    _style = style;
    if(style == JWCircleLoadingStyleGradient) {
        _circleLayer.strokeEnd = 1.0;
        if (!_gradientLayer) {
            _gradientLayer = [CALayer layer];
            _gradientLayer.mask = _circleLayer;
            
            CAGradientLayer *g0 = [CAGradientLayer layer];
            CAGradientLayer *g1 = [CAGradientLayer layer];
            
            [_gradientLayer addSublayer:g0];
            [_gradientLayer addSublayer:g1];
            
            [self setGradientLayerColor];
        }
        [_circleLayer removeFromSuperlayer];
        [self.layer addSublayer:_gradientLayer];
        
    } else {
        if (_gradientLayer) {
            [_gradientLayer removeFromSuperlayer];
            _gradientLayer = nil;
        }
        
        if (!_circleLayer.superlayer) {
            [self.layer addSublayer:_circleLayer];
        }
        
        if (style == JWCircleLoadingStyleDefault) {
            _circleLayer.strokeEnd = 0.6;
        } else if(style == JWCircleLoadingStyleCumulative) {
            _circleLayer.strokeEnd = 0;
        }
    }
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        _circleLayer.lineWidth = lineWidth;
        [self layoutLayers];
    }
}

- (void)setDrawBackground:(BOOL)drawBackground {
    if (_drawBackground != drawBackground) {
        _drawBackground = drawBackground;
        [self setNeedsDisplay];
    }
}

#pragma mark - JWLoadingViewProtocol
- (void)startAnimating {
    if (self.isAnimating) {
        return ;
    }
    self.isAnimating = YES;
    NSTimeInterval duration = 1.5f;
    if (self.style == JWCircleLoadingStyleCumulative) {
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
    } else if(self.style == JWCircleLoadingStyleDefault){
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = duration;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = INFINITY;
        
        [_circleLayer addAnimation:rotationAnimation forKey:nil];
    } else if(self.style == JWCircleLoadingStyleGradient) {
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = duration;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = INFINITY;
        
        [_gradientLayer addAnimation:rotationAnimation forKey:nil];
    }
}

- (void)stopAnimating {
    if (self.isAnimating) {
        [_circleLayer removeAllAnimations];
        self.isAnimating = NO;
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
    
    if (_gradientLayer) {
        _gradientLayer.frame = self.bounds;
        CAGradientLayer *g0 = (id)_gradientLayer.sublayers[0];
        CAGradientLayer *g1 = (id)_gradientLayer.sublayers[1];
        g0.frame = CGRectMake(0, 0, self.w * .5f, self.h);
        g1.frame = CGRectMake(self.w * .5f, 0, self.w * .5f, self.h);
        _gradientLayer.mask = _circleLayer;
    }
}

- (void)setGradientLayerColor {
    if (!_gradientLayer) {
        return;
    }
    CAGradientLayer *g0 = (id)_gradientLayer.sublayers[0];
    CAGradientLayer *g1 = (id)_gradientLayer.sublayers[1];
    
    g0.colors = @[(id)[self.tintColor colorWithAlphaComponent:0.5].CGColor, (id)[self.tintColor colorWithAlphaComponent:0.15].CGColor];
    g0.startPoint = CGPointMake(1.0, 1.0);
    g0.endPoint = CGPointMake(1.0, 0.0);
    
    g1.colors = @[(id)[self.tintColor colorWithAlphaComponent:0.5].CGColor, (id)self.tintColor.CGColor];
    g1.startPoint = CGPointMake(1.0, 1.0);
    g1.endPoint = CGPointMake(1.0, .0);
}

@end
