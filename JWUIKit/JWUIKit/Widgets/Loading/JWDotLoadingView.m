//
//  JWDotCircleLoadingView.m
//  JWUIKit
//
//  Created by Jerry on 16/3/31.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWDotLoadingView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"
#import "JWAlgorithm.h"

@implementation JWDotLoadingView {
    NSArray<CAShapeLayer*> *_dotViews;
}

JWUIKitInitialze {
    NSMutableArray *mDotArray = @[].mutableCopy;
    for(int i = 0; i < 5; i++) {
        CAShapeLayer *dotLayer = [CAShapeLayer layer];
        [self.layer addSublayer:dotLayer];
        [mDotArray addObject:dotLayer];
    }
    _dotViews = mDotArray;
    [self setupDotColor];
}

- (void)startAnimating {
    if (_isAnimating) {
        return ;
    }
    _isAnimating = YES;
    
    NSTimeInterval duration = 1.6f;
    if (self.style == JWDotLoadingStyleCircle) {
        CAKeyframeAnimation* rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.duration = duration;
        rotationAnimation.cumulative = YES;
        rotationAnimation.values = @[@(0), @(M_PI + M_PI_2), @(M_PI * 2)];
        rotationAnimation.keyTimes = @[@(0), @(0.5f), @(1)];
        rotationAnimation.repeatCount = INFINITY;
        
        [CATransaction begin];
        CFTimeInterval currentMediaTime = CACurrentMediaTime();
        [_dotViews enumerateObjectsUsingBlock:^(CAShapeLayer *dotLayer, NSUInteger idx, BOOL *stop) {
            rotationAnimation.beginTime = currentMediaTime + 0.1f * idx;
            [dotLayer addAnimation:rotationAnimation forKey:nil];
        }];
        [CATransaction commit];
    } else if(self.style == JWDotLoadingStyleLine) {
        CAKeyframeAnimation* rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        rotationAnimation.duration = duration;
        rotationAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(- self.w, 0, 0)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.w * .2f, 0, 0)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.w, 0, 0)],];
        rotationAnimation.keyTimes = @[@(0), @(0.5f), @(0.6), @(1)];
        rotationAnimation.autoreverses = YES;
        rotationAnimation.repeatCount = INFINITY;
        
        [CATransaction begin];
        CFTimeInterval currentMediaTime = CACurrentMediaTime();
        [_dotViews enumerateObjectsUsingBlock:^(CAShapeLayer *dotLayer, NSUInteger idx, BOOL *stop) {
            rotationAnimation.beginTime = currentMediaTime + 0.1f * idx;
            [dotLayer addAnimation:rotationAnimation forKey:nil];
        }];
        [CATransaction commit];
    }
}

- (void)stopAnimating {
    if (_isAnimating) {
        [_dotViews makeObjectsPerformSelector:@selector(removeAllAnimations)];
        _isAnimating = NO;
    }
}

- (void)tintColorDidChange {
    [self setupDotColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutDotViews];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(30, 30);
}

- (void)sizeToFit {
    CGRect frame = self.frame;
    CGSize intrinsicContentSize = [self intrinsicContentSize];
    frame.size = intrinsicContentSize;
    self.frame = frame;
}

#pragma mark - Setter & Getter
- (void)setStyle:(JWDotLoadingStyle)style {
    if (_style != style) {
        _style = style;
        if (self.style == JWDotLoadingStyleLine) {
            self.layer.masksToBounds = YES;
        } else {
            self.layer.masksToBounds = NO;
        }
        [self layoutDotViews];
    }
}

#pragma mark - Private
- (void)setupDotColor {
    for (CAShapeLayer *dotLayer in _dotViews) {
        dotLayer.fillColor = self.tintColor.CGColor;
    }
}

- (void)layoutDotViews {
    if (self.style == JWDotLoadingStyleCircle) {
        CGFloat contentWidth = MIN(self.w, self.h);
        CGFloat dotRadius = contentWidth * .5f / 6.0f;
        CGFloat stepAngle = JWRadians(80.0) / 5.0f;
        __block CGFloat startAngle = 0;
        CGFloat radius = (contentWidth * .5f) - dotRadius;
        
        [_dotViews enumerateObjectsUsingBlock:^(CAShapeLayer *dotView, NSUInteger idx, BOOL *stop) {
            dotView.frame = self.bounds;
            CGFloat x = radius * (1 - sin(startAngle));
            CGFloat y = radius * (1 - cos(startAngle));
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, x, y);
            CGPathAddArc(path, NULL, x, y, dotRadius, 0, M_PI * 2, 0);
            dotView.path = path;
            CGPathRelease(path);
            
            startAngle += stepAngle;
        }];
    } else if(self.style == JWDotLoadingStyleLine) {
        CGFloat dotRadius = self.w * .5f / 6.0f;
        CGFloat padding = (self.w - (dotRadius * 18)) * .5f;
        CGFloat y = self.h * .5f;
        
        __block CGFloat x = self.w - padding - dotRadius;
        
        [_dotViews enumerateObjectsUsingBlock:^(CAShapeLayer *dotView, NSUInteger idx, BOOL *stop) {
            dotView.frame = self.bounds;
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, x, y);
            CGPathAddArc(path, NULL, x, y, dotRadius, 0, M_PI * 2, 0);
            dotView.path = path;
            CGPathRelease(path);
            
            x -= dotRadius * 4;
        }];
    }
}

@end
