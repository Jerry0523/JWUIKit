//
//  JWSoundLikeLoadingView.m
//  JWUIKit
//
//  Created by 王杰 on 16/3/27.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWSoundLikeLoadingView.h"
//Core
#import "JWAlgorithm.h"
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWSoundLikeLoadingView {
    NSArray<CAShapeLayer*> *_layers;
}

JWUIKitInitialze {
    self.barsCount = 3;
    self.barsMarginPercent = 0.6f;
    
    self.duration = 0.35f;
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
    if (!_isAnimating) {
        _isAnimating = YES;
        
        [CATransaction begin];
        CGFloat barDuration = self.duration;
        CFTimeInterval currentMediaTime = CACurrentMediaTime();
        
        [_layers enumerateObjectsUsingBlock:^(CAShapeLayer *bar, NSUInteger idx, BOOL *stop) {
            CABasicAnimation *barAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            barAnimation.duration = barDuration;
            barAnimation.fromValue = @(0);
            barAnimation.toValue = @(1);
            barAnimation.fillMode = kCAFillModeBoth;
            barAnimation.beginTime = currentMediaTime + idx * JWRandom(50, 101) * barDuration / 100.0f;
            barAnimation.repeatCount = INFINITY;
            barAnimation.autoreverses = YES;
            
            [bar addAnimation:barAnimation forKey:nil];
        }];
        
        [CATransaction commit];
        
    }
}

- (void)stopAnimating {
    if (_isAnimating) {
        [_layers makeObjectsPerformSelector:@selector(removeAllAnimations)];
        _isAnimating = NO;
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
            if (self.tintColor) {
                [self setupBarsColor];
            }
            [self layoutBarLayers];
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
        barLayer.strokeEnd = 0;
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
