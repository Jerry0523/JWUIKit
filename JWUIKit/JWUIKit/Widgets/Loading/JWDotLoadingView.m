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

- (void)setup {
    [super setup];
    self.dotCount = 5;
}

- (void)startAnimating {
    if (self.isAnimating) {
        return ;
    }
    self.isAnimating = YES;
    
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
                                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(- self.w * 0.2f, 0, 0)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.w, 0, 0)],];
        rotationAnimation.keyTimes = @[@(0), @(0.3f), @(0.7), @(1)];
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
    if (self.isAnimating) {
        [_dotViews makeObjectsPerformSelector:@selector(removeAllAnimations)];
        self.isAnimating = NO;
    }
}

- (void)tintColorDidChange {
    for (CAShapeLayer *dotLayer in _dotViews) {
        dotLayer.fillColor = self.tintColor.CGColor;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutDotViews];
}

- (CGSize)intrinsicContentSize {
    if (self.style == JWDotLoadingStyleLine) {
        return CGSizeMake(60, 30);
    }
    return CGSizeMake(30, 30);
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
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

- (void)setDotCount:(NSUInteger)dotCount {
    if (dotCount && _dotCount != dotCount) {
        _dotCount = dotCount;
        [self setupDotsLayer];
    }
}

#pragma mark - Private
- (void)setupDotsLayer {
    [_dotViews makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    NSMutableArray *mDotArray = @[].mutableCopy;
    for(int i = 0; i < self.dotCount; i++) {
        CAShapeLayer *dotLayer = [CAShapeLayer layer];
        [self.layer addSublayer:dotLayer];
        [mDotArray addObject:dotLayer];
    }
    _dotViews = mDotArray;
    [self tintColorDidChange];
}

- (void)layoutDotViews {
    if (self.style == JWDotLoadingStyleCircle) {
        CGFloat contentWidth = MIN(self.w, self.h);
        CGFloat dotRadius = 3;
        CGFloat stepAngle = 0.38f;
        __block CGFloat startAngle = 0;
        CGFloat radius = (contentWidth * .5f) - dotRadius;
        
        [_dotViews enumerateObjectsUsingBlock:^(CAShapeLayer *dotView, NSUInteger idx, BOOL *stop) {
            dotView.frame = self.bounds;
            CGFloat x = radius * (1 - sin(startAngle));
            CGFloat y = radius * (1 - cos(startAngle));
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddArc(path, NULL, x, y, dotRadius, 0, M_PI * 2, 0);
            dotView.path = path;
            CGPathRelease(path);
            
            startAngle += stepAngle;
        }];
    } else if(self.style == JWDotLoadingStyleLine) {
        CGFloat dotRadius = 3;
        CGFloat padding = (self.w - (dotRadius * ((self.dotCount - 1) + self.dotCount * 2))) * .5f;
        CGFloat y = self.h * .5f;
        
        __block CGFloat x = self.w - padding - dotRadius;
        
        [_dotViews enumerateObjectsUsingBlock:^(CAShapeLayer *dotView, NSUInteger idx, BOOL *stop) {
            dotView.frame = self.bounds;
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, x, y);
            CGPathAddArc(path, NULL, x, y, dotRadius, 0, M_PI * 2, 0);
            dotView.path = path;
            CGPathRelease(path);
            
            x -= dotRadius * 3;
        }];
    }
}

@end
