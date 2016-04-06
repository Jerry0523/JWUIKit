//
//  JWBarLoadingView.m
//  JWUIKit
//
//  Created by 王杰 on 16/3/27.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWBarLoadingView.h"
//Core
#import "JWAlgorithm.h"
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWBarLoadingView {
    NSArray<CAShapeLayer*> *_layers;
}

- (void)setup {
    [super setup];
    self.barsCount = 4;
    self.barsMarginPercent = 0.6f;
    self.duration = 0.4f;
    self.style = JWBarLoadingStyleSound;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutBarLayers];
}

- (void)tintColorDidChange {
    if (_layers.count) {
        [self setupBarsColor];
    }
}

#pragma mark - JWLoadingViewProtocol
- (void)startAnimating {
    if (self.isAnimating) {
        return;
    }
    self.isAnimating = YES;
    
    [CATransaction begin];
    CGFloat barDuration = self.duration;
    CFTimeInterval currentMediaTime = CACurrentMediaTime();
    
    [_layers enumerateObjectsUsingBlock:^(CAShapeLayer *bar, NSUInteger idx, BOOL *stop) {
        if (self.style == JWBarLoadingStyleSound) {
            CABasicAnimation *barAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            barAnimation.duration = barDuration;
            barAnimation.fromValue = @(0);
            barAnimation.toValue = @(1);
            barAnimation.fillMode = kCAFillModeBoth;
            barAnimation.beginTime = currentMediaTime + idx * JWRandom(50, 101) * barDuration / 100.0f;
            barAnimation.repeatCount = INFINITY;
            barAnimation.autoreverses = YES;
            
            [bar addAnimation:barAnimation forKey:nil];
        } else if(self.style == JWBarLoadingStyleWave) {
            
            CAKeyframeAnimation *strokeStartAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
            strokeStartAnimation.keyTimes = @[@(0.0), @(0.2), @(0.4), @(1.0)];
            strokeStartAnimation.values = @[@(0.3f), @(0), @(0.3f), @(0.3f)];
            strokeStartAnimation.duration = barDuration * self.barsCount;
            strokeStartAnimation.fillMode = kCAFillModeBoth;
            
            CAKeyframeAnimation *strokeEndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
            strokeEndAnimation.keyTimes = @[@(0.0), @(0.2), @(0.4), @(1.0)];
            strokeEndAnimation.values = @[@(0.7f), @(1), @(0.7f), @(0.7f)];
            strokeEndAnimation.duration = barDuration * self.barsCount;
            strokeEndAnimation.fillMode = kCAFillModeBoth;
            
            CAAnimationGroup *groupAnimation = [CAAnimationGroup new];
            groupAnimation.animations = @[strokeEndAnimation, strokeStartAnimation];
            groupAnimation.repeatCount = INFINITY;
            groupAnimation.beginTime = currentMediaTime + idx * barDuration;
            groupAnimation.duration = barDuration * self.barsCount;
            
            [bar addAnimation:groupAnimation forKey:nil];
        }
    }];
    
    [CATransaction commit];
}

- (void)stopAnimating {
    if (self.isAnimating) {
        [_layers makeObjectsPerformSelector:@selector(removeAllAnimations)];
        self.isAnimating = NO;
    }
}

#pragma mark - Setter & Getter
- (void)setBarsCount:(CGFloat)barsCount {
    if (barsCount && _barsCount != barsCount) {
        _barsCount = barsCount;
        if (_layers.count != barsCount) {
            [_layers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
            NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:barsCount];
            for (int i = 0; i < barsCount; i++) {
                CAShapeLayer *barLayer = [CAShapeLayer layer];
                [mutableArray addObject:barLayer];
                [self.layer addSublayer:barLayer];
            }
            _layers = mutableArray;
            [self setupBarsColor];
            [self layoutBarLayers];
        }
    }
}

- (void)setStyle:(JWBarLoadingStyle)style {
    _style = style;
    for (CAShapeLayer *barLayer in _layers) {
        if (style == JWBarLoadingStyleSound) {
            barLayer.strokeStart = 0;
            barLayer.strokeEnd = 0;
        } else if(style == JWBarLoadingStyleWave) {
            barLayer.strokeStart = 0.3f;
            barLayer.strokeEnd = 0.7f;
        }
    }
    
}

- (void)setBarsMarginPercent:(CGFloat)barsMarginPercent {
    if (_barsMarginPercent != barsMarginPercent) {
        _barsMarginPercent = barsMarginPercent;
        if (_layers.count) {
            [self layoutBarLayers];
        }
    }
}

#pragma mark - Private
- (void)setupBarsColor {
    for (CAShapeLayer *barLayer in _layers) {
        barLayer.strokeColor = self.tintColor.CGColor;
        barLayer.fillColor = [UIColor clearColor].CGColor;
    }
}

- (void)layoutBarLayers {
    CGFloat barWidth = self.w / (self.barsCount + (self.barsCount - 1) * self.barsMarginPercent);
    [_layers enumerateObjectsUsingBlock:^(CAShapeLayer *bar, NSUInteger idx, BOOL *stop) {
        bar.frame = CGRectMake((barWidth * (1.0 + self.barsMarginPercent)) * idx, 0, barWidth, self.h);
        bar.lineWidth = barWidth;
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, barWidth * .5f, self.h);
        CGPathAddLineToPoint(path, NULL, barWidth * .5f, 0);
        
        bar.path = path;
        CGPathRelease(path);
    }];
}

@end
