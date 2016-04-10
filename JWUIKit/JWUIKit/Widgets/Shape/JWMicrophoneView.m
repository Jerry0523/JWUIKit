//
//  JWMicrophoneView.m
//  JWUIKit
//
//  Created by Jerry on 16/3/28.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWMicrophoneView.h"
//Core
#import "JWAlgorithm.h"
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

#define kConvertByRatio(value, dest) JWConvertValue(value, 100.0f, dest)

@implementation JWMicrophoneView {
    CAShapeLayer *_microphoneLayer;
    CAShapeLayer *_volumeLayer;
}

JWUIKitInitialze {
    _microphoneLayer = [CAShapeLayer layer];
    _microphoneLayer.fillColor = [UIColor clearColor].CGColor;
    _microphoneLayer.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:_microphoneLayer];
    
    _volumeLayer = [CAShapeLayer layer];
    _volumeLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.lineWidth = 4.0;

    [self.layer addSublayer:_volumeLayer];
    [self setLayerColor];
}

- (void)layoutSubviews {
    [self layoutLayers];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(80, 80);
}

- (void)tintColorDidChange {
    [self setLayerColor];
}

#pragma mark - Setter & Getter
- (void)setVolumn:(CGFloat)volumn {
    if (_volumn != volumn) {
        _volumn = JWValueConformTo(volumn, 0, 1);
        _volumeLayer.fillColor = [self.tintColor colorWithAlphaComponent:volumn].CGColor;
    }
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        _microphoneLayer.lineWidth = lineWidth;
    }
}

#pragma mark - Private
- (void)setLayerColor {
    _microphoneLayer.strokeColor = self.tintColor.CGColor;
}

- (void)layoutLayers {
    CGFloat layerSize = MIN(self.w, self.h);
    _microphoneLayer.frame = CGRectMake((self.w - layerSize) * .5f, (self.h - layerSize) * .5f, layerSize, layerSize);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(kConvertByRatio(28, layerSize), kConvertByRatio(98, layerSize))];
    [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(72, layerSize), kConvertByRatio(98, layerSize))];
    
    [bezierPath moveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(98, layerSize))];
    [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(90, layerSize))];
    
    [bezierPath moveToPoint:CGPointMake(kConvertByRatio(20, layerSize), kConvertByRatio(52, layerSize))];
    [bezierPath addQuadCurveToPoint: CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(90, layerSize))
                       controlPoint: CGPointMake(kConvertByRatio(22, layerSize), kConvertByRatio(88, layerSize))];
    [bezierPath addQuadCurveToPoint: CGPointMake(kConvertByRatio(80, layerSize), kConvertByRatio(52, layerSize))
                       controlPoint: CGPointMake(kConvertByRatio(78, layerSize), kConvertByRatio(88, layerSize))];
    
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kConvertByRatio(32, layerSize), kConvertByRatio(2, layerSize), kConvertByRatio(36, layerSize), kConvertByRatio(74, layerSize)) cornerRadius:kConvertByRatio(18, layerSize)];
    [bezierPath appendPath:roundPath];
    
    _microphoneLayer.path = bezierPath.CGPath;
    
    _volumeLayer.frame = CGRectMake((self.w - layerSize) * .5f, (self.h - layerSize) * .5f, layerSize, layerSize);
    roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kConvertByRatio(36, layerSize), kConvertByRatio(6, layerSize), kConvertByRatio(28, layerSize), kConvertByRatio(66, layerSize)) cornerRadius:kConvertByRatio(18, layerSize)];
    
    _volumeLayer.path = roundPath.CGPath;

}

@end
