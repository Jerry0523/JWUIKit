//
//  JWArrow.m
//  JWUIKit
//
//  Created by 王杰 on 16/4/9.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWArrow.h"
//Core
#import "JWAlgorithm.h"
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

#define kConvertByRatio(value, dest) JWConvertValue(value, 100.0f, dest)

@implementation JWArrow {
    CAShapeLayer *_arrowLayer;
}

JWUIKitInitialze {
    _arrowLayer = [CAShapeLayer layer];
    _arrowLayer.fillColor = [UIColor clearColor].CGColor;
    _arrowLayer.lineCap = kCALineCapRound;
    _arrowLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:_arrowLayer];
    
    self.lineWidth = 4.0;
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
- (void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        _arrowLayer.lineWidth = lineWidth;
    }
}

- (void)setDirection:(JWArrowDirection)direction {
    if (_direction != direction) {
        _direction = direction;
        
        CGFloat angle = 0;
        
        switch (direction) {
            case JWArrowDirectionLeft:
                angle = -M_PI_2;
                break;
            case JWArrowDirectionBottom:
                angle = -M_PI;
                break;
            case JWArrowDirectionRight:
                angle = M_PI_2;
                break;
        }
        [UIView animateWithDuration:.25 animations:^{
            self.transform = CGAffineTransformMakeRotation(angle);
        }];
    }
}

#pragma mark - Private
- (void)setLayerColor {
    _arrowLayer.strokeColor = self.tintColor.CGColor;
}

- (void)layoutLayers {
    _arrowLayer.frame = self.bounds;
    
    CGFloat layerSize = MIN(self.w, self.h);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(98, layerSize))];
    [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(2, layerSize))];
    [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(20, layerSize), kConvertByRatio(36, layerSize))];
    [bezierPath moveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(2, layerSize))];
    [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(80, layerSize), kConvertByRatio(36, layerSize))];
    
    _arrowLayer.path = bezierPath.CGPath;
}

@end
