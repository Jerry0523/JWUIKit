//
//  JWCircleProgressView.m
//  JWUIKit
//
//  Created by Jerry on 16/3/22.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWCircleProgressView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWCircleProgressView {
    CAShapeLayer *layer;
}

JWUIKitInitialze {
    _style = -1;
    layer = [CAShapeLayer layer];
    [self.layer addSublayer:layer];
    self.style = JWCircleProgressStyleDefault;
}

- (void)layoutSubviews {
    layer.frame = self.bounds;
    [self setupShape];
}

#pragma mark - Setter & Getter
- (void)setProgress:(CGFloat)progress {
    if (_progress != progress) {
        _progress = MIN(1.0f, MAX(0.0f, progress));
        if (self.style == JWCircleProgressStyleDefault) {
            layer.strokeEnd = _progress;
        } else {
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnimation.fromValue = (__bridge id)(layer.path);
            [self setupShape];
            pathAnimation.toValue = (__bridge id)(layer.path);
            [layer addAnimation:pathAnimation forKey:nil];
            [CATransaction commit];
        }
    }
}

- (void)setStyle:(JWCircleProgressStyle)style {
    if (_style != style) {
        _style = style;
        if (style == JWCircleProgressStyleDefault) {
            layer.lineWidth = 4.0f;
            layer.lineCap = @"round";
            layer.strokeEnd = 0;
            
        } else if(style == JWCircleProgressStylePie) {
            
            layer.fillColor = [UIColor whiteColor].CGColor;
            layer.strokeColor = [UIColor clearColor].CGColor;
        }
        self.color = _color;
    }
}

- (void)setColor:(UIColor *)color {
    if (!color) {
        color = [UIColor whiteColor];
    }
    _color = color;
    if (self.style == JWCircleProgressStyleDefault) {
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = _color.CGColor;
        layer.lineWidth = 4.0f;
        layer.lineCap = @"round";
        layer.strokeEnd = 0;
        
    } else if(self.style == JWCircleProgressStylePie) {
        layer.fillColor = _color.CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
    }
}

#pragma mark - Private
- (void)setupShape {
    CGMutablePathRef path = CGPathCreateMutable();
    if (self.style == JWCircleProgressStylePie) {
        CGPathMoveToPoint(path, NULL, self.w * .5f, self.h * .5f);
    }
    CGFloat circleProgress = (self.style == JWCircleProgressStylePie ? self.progress : 1.0);
    CGPathAddArc(path, NULL, self.w * .5f, self.h * .5f, MIN(self.w, self.h) * .5f, -M_PI_2, -M_PI_2 + M_PI * 2 * circleProgress, 0);
    layer.path = path;
    CGPathRelease(path);
}


@end
