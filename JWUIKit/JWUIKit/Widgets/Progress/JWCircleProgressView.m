//
//  JWCircleProgressView.m
//  JWUIKit
//
//  Created by Jerry on 16/3/22.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWCircleProgressView.h"
//Core
#import "JWAlgorithm.h"
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWCircleProgressView {
    CAShapeLayer *_layer;
}

JWUIKitInitialze {
    _style = -1;
    _layer = [CAShapeLayer layer];
    [self.layer addSublayer:_layer];
    
    self.showBackground = YES;
    
    self.tintColor = [UIColor whiteColor];
    self.style = JWCircleProgressStyleDefault;
}

- (void)layoutSubviews {
    [self setupShape];
}

- (void)drawRect:(CGRect)rect {
    if (self.showBackground) {
        if (self.style == JWCircleProgressStyleDefault) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 4.0);
            
            CGContextSetStrokeColorWithColor(context, [self.tintColor colorWithAlphaComponent:0.2].CGColor);
            CGContextBeginPath(context);
            CGContextAddPath(context, _layer.path);
            CGContextStrokePath(context);
            
        } else if(self.style == JWCircleProgressStylePie) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 1.0);
            
            CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
            CGContextBeginPath(context);
            
            CGFloat contentWidth = MIN(rect.size.width, rect.size.height) * .5f - 1.0f;
            CGContextAddArc(context, rect.size.width * .5f, rect.size.height * .5f, contentWidth, 0, M_PI * 2, 0);
            CGContextStrokePath(context);
        }
    }
}

#pragma mark - Setter & Getter
- (void)setProgress:(CGFloat)progress {
    if (_progress != progress) {
        _progress = JWValueConformTo(progress, 0, 1);
        if (self.style == JWCircleProgressStyleDefault) {
            _layer.strokeEnd = _progress;
        } else {
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnimation.fromValue = (__bridge id)(_layer.path);
            [self setupShape];
            pathAnimation.toValue = (__bridge id)(_layer.path);
            [_layer addAnimation:pathAnimation forKey:nil];
            [CATransaction commit];
        }
    }
}

- (void)setStyle:(JWCircleProgressStyle)style {
    if (_style != style) {
        _style = style;
        if (style == JWCircleProgressStyleDefault) {
            _layer.lineWidth = 4.0f;
            _layer.lineCap = kCALineCapRound;
            _layer.strokeEnd = 0;
        } else if(style == JWCircleProgressStylePie) {
            _layer.lineWidth = 1.0f;
        }
        [self setupLayerColor];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (!tintColor) {
        tintColor = [UIColor whiteColor];
    }
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
        [self setupLayerColor];
    }
}

#pragma mark - Private
- (void)setupLayerColor {
    if (self.style == JWCircleProgressStyleDefault) {
        _layer.fillColor = [UIColor clearColor].CGColor;
        _layer.strokeColor = _tintColor.CGColor;
        
    } else if(self.style == JWCircleProgressStylePie) {
        _layer.fillColor = _tintColor.CGColor;
        _layer.strokeColor = [UIColor clearColor].CGColor;
    }
}

- (void)setupShape {
    _layer.frame = self.bounds;
    
    CGMutablePathRef path = CGPathCreateMutable();
    if (self.style == JWCircleProgressStylePie) {
        CGPathMoveToPoint(path, NULL, self.w * .5f, self.h * .5f);
    }
    CGFloat circleProgress = (self.style == JWCircleProgressStylePie ? self.progress : 1.0);
    CGFloat radius = (MIN(self.w, self.h) - _layer.lineWidth) * .5f;
    CGPathAddArc(path, NULL, self.w * .5f, self.h * .5f, radius, -M_PI_2, -M_PI_2 + M_PI * 2 * circleProgress, 0);
    _layer.path = path;
    CGPathRelease(path);
}


@end
