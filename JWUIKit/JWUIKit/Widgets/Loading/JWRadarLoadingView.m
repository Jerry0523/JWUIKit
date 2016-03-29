//
//  JWRadarLoadingView.m
//  JWUIKit
//
//  Created by 王杰 on 16/3/27.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWRadarLoadingView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWRadarLoadingView {
    CAShapeLayer *_centerCirclelLayer;
    NSArray<CAShapeLayer*> *_ringLayersArray;
    NSArray<UIColor*> *_colors;
}

JWUIKitInitialze {
    self.circleAnimationDuration = 0.2f;
    self.ringAnimationDuration = 0.25f;
    
    self.tintColor = [UIColor redColor];
    self.ringsCount = 2;
    self.centerCircleRadiusPercent = .3f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutLayers];
}

#pragma mark - JWLoadingViewProtocol

- (void)startAnimating {
    if (_isAnimating) {
        return ;
    }
    _isAnimating = YES;
    
    [CATransaction begin];
    
    CABasicAnimation *centerCircleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    centerCircleAnimation.duration = self.circleAnimationDuration;
    
    centerCircleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2f, 0.2f, 1.0)];
    centerCircleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    [_centerCirclelLayer addAnimation:centerCircleAnimation forKey:nil];
    
    _centerCirclelLayer.opacity = 1.0f;
    
    CFTimeInterval currentMediaTime = CACurrentMediaTime();
    
    CGFloat ringLineWidth = [self ringLineWidth];
    CGFloat startOffset = round([self centerCircleRadius] - 0.5 * ringLineWidth);
    
    
    [_ringLayersArray enumerateObjectsUsingBlock:^(CAShapeLayer *ringLayer, NSUInteger idx, BOOL *stop) {        
        CABasicAnimation *ringTransformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        ringTransformAnimation.duration = self.ringAnimationDuration;
        CGFloat fromScale = (startOffset + idx * 2.0 * ringLineWidth) / (startOffset + (idx + 1) * 2.0 * ringLineWidth);        ringTransformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(fromScale, fromScale, 1.0)];;
        ringTransformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        ringTransformAnimation.fillMode = kCAFillModeBoth;
        
        CABasicAnimation *ringAlphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        ringAlphaAnimation.duration = self.ringAnimationDuration;
        ringAlphaAnimation.fromValue = @(0);
        ringAlphaAnimation.toValue = @(1.0);
        ringAlphaAnimation.fillMode = kCAFillModeBoth;
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup new];
        groupAnimation.animations = @[ringTransformAnimation, ringAlphaAnimation];
        groupAnimation.duration = self.ringAnimationDuration * self.ringsCount;
        groupAnimation.beginTime = currentMediaTime + self.circleAnimationDuration + self.ringAnimationDuration * idx;
        groupAnimation.repeatCount = INFINITY;
        groupAnimation.autoreverses = YES;
        
        [ringLayer addAnimation:groupAnimation forKey:nil];
    }];
    
    [CATransaction commit];
}

- (void)stopAnimating {
    if (_isAnimating) {
        [_centerCirclelLayer removeAllAnimations];
        _centerCirclelLayer.opacity = 0.0f;
        [_ringLayersArray makeObjectsPerformSelector:@selector(removeAllAnimations)];
        _isAnimating = NO;
    }
}

#pragma mark - Setter & Getter
- (void)setTintColor:(UIColor *)tintColor {
    if (_tintColor != tintColor) {
         _tintColor = tintColor;
        [self setupColorsByTintColor:tintColor];
    }
   
}

- (void)setRingsCount:(CGFloat)ringsCount {
    if (ringsCount && _ringsCount != ringsCount) {
        _ringsCount = ringsCount;
        if (_tintColor) {
            [self setupColorsByTintColor:_tintColor];
        }
        if (_ringLayersArray.count != ringsCount) {
            [_ringLayersArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:ringsCount];
            for (int i = 0; i < ringsCount; i++) {
                CAShapeLayer *layer = [CAShapeLayer new];
                [self.layer addSublayer:layer];
                [array addObject:layer];
            }
            _ringLayersArray = array;
            [self setupRingLayers];
        }
    }
}

- (void)setCenterCircleRadiusPercent:(CGFloat)centerCircleRadiusPercent {
    if (_centerCircleRadiusPercent != centerCircleRadiusPercent) {
        _centerCircleRadiusPercent = centerCircleRadiusPercent;
        [self layoutLayers];
    }
}

#pragma mark - Private
- (void)setupLayers {
    [self setupCircleLayer];
    [self setupRingLayers];
}

- (void)setupCircleLayer {
    if (!_centerCirclelLayer) {
        _centerCirclelLayer = [CAShapeLayer layer];
        _centerCirclelLayer.opacity = 0.0f;
        [self.layer addSublayer:_centerCirclelLayer];
    }
    _centerCirclelLayer.fillColor = _colors[0].CGColor;
    _centerCirclelLayer.strokeColor = [UIColor clearColor].CGColor;
    _centerCirclelLayer.lineWidth = 0.0f;
}

- (void)setupRingLayers {
    [_ringLayersArray enumerateObjectsUsingBlock:^(CAShapeLayer * layer, NSUInteger idx, BOOL *stop) {
        if (idx < _colors.count - 1) {
            layer.strokeColor = _colors[idx + 1].CGColor;
            layer.fillColor = [UIColor clearColor].CGColor;
            layer.opacity = 0.0f;
        }
    }];
}

- (CGFloat)centerCircleRadius {
    CGFloat superContentSize = round(MIN(self.w, self.h) * .5f);
    return round(superContentSize * self.centerCircleRadiusPercent);;
}

- (CGFloat)ringLineWidth {
    CGFloat superContentSize = round(MIN(self.w, self.h) * .5f);
    CGFloat centerRadius = [self centerCircleRadius];
    return round((superContentSize - centerRadius) / (self.ringsCount * 2.0f));
}

- (void)layoutLayers {
    _centerCirclelLayer.frame = self.bounds;
    CGFloat centerRadius = [self centerCircleRadius];
    
    CGMutablePathRef centerPath = CGPathCreateMutable();
    CGPathAddArc(centerPath, NULL, self.w * .5f, self.h * .5f, centerRadius, 0, M_PI * 2.0f, NO);
    _centerCirclelLayer.path = centerPath;
    CGPathRelease(centerPath);
    
    CGFloat ringLineWidth = [self ringLineWidth];
    CGFloat stepOffset = 2.0 * ringLineWidth;
    
    __block CGFloat offsetRadius = round(centerRadius - .5 * ringLineWidth);
    
    [_ringLayersArray enumerateObjectsUsingBlock:^(CAShapeLayer * ringLayer, NSUInteger idx, BOOL *stop) {
        offsetRadius += stepOffset;
        ringLayer.frame = self.bounds;
        ringLayer.lineWidth = ringLineWidth;
        
        CGMutablePathRef centerPath = CGPathCreateMutable();
        CGPathAddArc(centerPath, NULL, self.w * .5f, self.h * .5f, offsetRadius, 0, M_PI * 2.0f, NO);
        ringLayer.path = centerPath;
        
        CGPathRelease(centerPath);
        
    }];
}

- (void)setupColorsByTintColor:(UIColor*)tintColor {
    NSUInteger colorsCount = self.ringsCount + 1;
    CGFloat colorsDamping = (1.0 - 0.01) / colorsCount;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:colorsCount];
    for (int i = 0; i < colorsCount; i++) {
        CGFloat colorAlpha = 1.0 - colorsDamping * i;
        UIColor *idxColor = [tintColor colorWithAlphaComponent:colorAlpha];
        [array addObject:idxColor];
    }
    _colors = array;
    [self setupLayers];
}

@end
