//
//  JWSimpleShape.m
//  JWUIKit
//
//  Created by Jerry on 16/4/12.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWSimpleShape.h"
//Core
#import "JWAlgorithm.h"
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

NSString *const JWSimpleShapeTypeYes = @"yes";
NSString *const JWSimpleShapeTypeArrow = @"arrow";
NSString *const JWSimpleShapeTypeHeart = @"heart";

NSString *const JWSimpleShapeSubTypeArrowTop = @"top";
NSString *const JWSimpleShapeSubTypeArrowBottom = @"bottom";
NSString *const JWSimpleShapeSubTypeArrowLeft = @"left";
NSString *const JWSimpleShapeSubTypeArrowRight = @"right";

#define kConvertByRatio(value, dest) JWConvertValue(value, 100.0f, dest)

@implementation JWSimpleShape {
    CAShapeLayer *_shapeLayer;
}

JWUIKitInitialze {
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:_shapeLayer];
    
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

- (void)beginSimpleAnimation {
    if ([self.type isEqualToString:JWSimpleShapeTypeYes]) {
        [_shapeLayer removeAllAnimations];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(0.0f);
        animation.toValue = @(1.0f);
        animation.duration = 0.25f;
        [_shapeLayer addAnimation:animation forKey:nil];
    }
}

#pragma mark - Setter & Getter
- (void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        _shapeLayer.lineWidth = lineWidth;
    }
}

- (void)setSubType:(NSString *)subType {
    if (![_subType isEqualToString:subType]) {
        _subType = subType;
        if ([self.type isEqualToString:JWSimpleShapeTypeArrow]) {
            CGFloat angle = 0;
            if ([subType isEqualToString:JWSimpleShapeSubTypeArrowLeft]) {
                angle = -M_PI_2;
            } else if([subType isEqualToString:JWSimpleShapeSubTypeArrowBottom]) {
                angle = -M_PI;
            } else if([subType isEqualToString:JWSimpleShapeSubTypeArrowRight]) {
                angle = M_PI_2;
            }
            [UIView animateWithDuration:.25 animations:^{
                _shapeLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1.0);
            }];
        }
    }
}

#pragma mark - Private
- (void)setLayerColor {
    _shapeLayer.strokeColor = self.tintColor.CGColor;
}

- (void)layoutLayers {
    _shapeLayer.frame = self.bounds;
    
    CGFloat layerSize = MIN(self.w, self.h);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    if ([self.type isEqualToString:JWSimpleShapeTypeYes]) {
        [bezierPath moveToPoint:CGPointMake(kConvertByRatio(4, layerSize), kConvertByRatio(53, layerSize))];
        [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(40, layerSize), kConvertByRatio(90, layerSize))];
        [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(96, layerSize), kConvertByRatio(10, layerSize))];
    } else if([self.type isEqualToString:JWSimpleShapeTypeArrow]) {
        [bezierPath moveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(98, layerSize))];
        [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(2, layerSize))];
        [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(20, layerSize), kConvertByRatio(36, layerSize))];
        [bezierPath moveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(2, layerSize))];
        [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(80, layerSize), kConvertByRatio(36, layerSize))];
    } else if([self.type isEqualToString:JWSimpleShapeTypeHeart]) {
        [bezierPath moveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(30, layerSize))];
        
        [bezierPath addCurveToPoint:CGPointMake(kConvertByRatio(8, layerSize), kConvertByRatio(26, layerSize))
                      controlPoint1:CGPointMake(kConvertByRatio(28, layerSize), kConvertByRatio(3, layerSize))
                      controlPoint2:CGPointMake(kConvertByRatio(10, layerSize), kConvertByRatio(18, layerSize))];
        
        [bezierPath addCurveToPoint:CGPointMake(kConvertByRatio(11, layerSize), kConvertByRatio(51, layerSize))
                      controlPoint1:CGPointMake(kConvertByRatio(5, layerSize), kConvertByRatio(36, layerSize))
                      controlPoint2:CGPointMake(kConvertByRatio(6, layerSize), kConvertByRatio(45, layerSize))];
        
        [bezierPath addQuadCurveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(90, layerSize))
                           controlPoint:CGPointMake(kConvertByRatio(20, layerSize), kConvertByRatio(65, layerSize))];
        
        [bezierPath addQuadCurveToPoint:CGPointMake(kConvertByRatio(89, layerSize), kConvertByRatio(51, layerSize))
                           controlPoint:CGPointMake(kConvertByRatio(80, layerSize), kConvertByRatio(65, layerSize))];
        
        [bezierPath addCurveToPoint:CGPointMake(kConvertByRatio(92, layerSize), kConvertByRatio(26, layerSize))
                      controlPoint1:CGPointMake(kConvertByRatio(94, layerSize), kConvertByRatio(45, layerSize))
                      controlPoint2:CGPointMake(kConvertByRatio(95, layerSize), kConvertByRatio(36, layerSize))];
        
        [bezierPath addCurveToPoint:CGPointMake(kConvertByRatio(50, layerSize), kConvertByRatio(30, layerSize))
                      controlPoint1:CGPointMake(kConvertByRatio(90, layerSize), kConvertByRatio(18, layerSize))
                      controlPoint2:CGPointMake(kConvertByRatio(72, layerSize), kConvertByRatio(3, layerSize))];
    }
    _shapeLayer.path = bezierPath.CGPath;
}

@end
