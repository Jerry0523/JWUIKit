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

@implementation JWArrow

+ (Class)layerClass {
    return [CAShapeLayer class];
}

JWUIKitInitialze {
    CAShapeLayer *shapeLayer = self.layer;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    
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
        ((CAShapeLayer*)self.layer).lineWidth = lineWidth;
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
        self.transform = CGAffineTransformMakeRotation(angle);
    }
}

#pragma mark - Private
- (void)setLayerColor {
    ((CAShapeLayer*)self.layer).strokeColor = self.tintColor.CGColor;
}

- (void)layoutLayers {
    CGFloat layerSize = MIN(self.w, self.h);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(98, layerSize))];
    [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(2, layerSize))];
    [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(20, layerSize), kConvertByRatio(36, layerSize))];
    [bezierPath moveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(2, layerSize))];
    [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(80, layerSize), kConvertByRatio(36, layerSize))];
    
    ((CAShapeLayer*)self.layer).path = bezierPath.CGPath;
}

@end
