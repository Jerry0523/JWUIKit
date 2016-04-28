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
NSString *const JWSimpleShapeTypePentastar = @"pentastar";
NSString *const JWSimpleShapeTypeAdd = @"add";
NSString *const JWSimpleShapeTypeClose = @"close";

NSString *const JWSimpleShapeSubTypeArrowTop = @"top";
NSString *const JWSimpleShapeSubTypeArrowBottom = @"bottom";
NSString *const JWSimpleShapeSubTypeArrowLeft = @"left";
NSString *const JWSimpleShapeSubTypeArrowRight = @"right";

NSString *const JWSimpleShapeSubTypePentastarFilledHalf = @"half";

#define kConvertByRatio(value, dest) JWConvertValue([value floatValue], 100.0f, dest)

typedef NS_ENUM(NSInteger, JWSimpleShapeMethod) {
    JWSimpleShapeMethodLine = 0,
    JWSimpleShapeMethodMove = 1,
    JWSimpleShapeMethodCurve = 2,
    JWSimpleShapeMethodQuadCurve = 3,
    JWSimpleShapeMethodArc  = 4
};

@implementation JWSimpleShape {
    CAShapeLayer *_shapeLayer;
    NSArray *_data;
}

JWUIKitInitialze {
    self.backgroundColor = [UIColor clearColor];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:_shapeLayer];
    
    self.lineWidth = 2.0;
    self.filled = NO;
    
    [self setLayerColor];
}

- (void)layoutSubviews {
    [self layoutLayers];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(35, 35);
}

- (void)tintColorDidChange {
    [self setLayerColor];
    self.subType = _subType;
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

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if([self.type isEqualToString:JWSimpleShapeTypePentastar] && [self.subType isEqualToString:JWSimpleShapeSubTypePentastarFilledHalf]) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, _shapeLayer.path);
        CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
        
        CGRect range = CGRectMake(0, 0, self.w * .5f, self.h);
        
        CGContextClip(context);
        CGContextFillRect(context, range);
    }
}

#pragma mark - Setter & Getter
- (void)setType:(NSString *)type {
    _type = type;
    [self setupData];
    [self setNeedsLayout];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        _shapeLayer.lineWidth = lineWidth;
    }
}

- (void)setFilled:(BOOL)filled {
    _filled = filled;
    UIColor *filledColor = [UIColor clearColor];
    if(filled &&
       ([self.type isEqualToString:JWSimpleShapeTypeHeart] ||
       [self.type isEqualToString:JWSimpleShapeTypePentastar])) {
        filledColor = self.tintColor;
    }
    _shapeLayer.fillColor = filledColor.CGColor;
}

- (void)setSubType:(NSString *)subType {
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

#pragma mark - Private
- (void)setupData {
    if ([self.type isEqualToString:JWSimpleShapeTypeYes]) {
        _data =  @[@"4,53|1", @"40,90", @"96,10"];
    } else if([self.type isEqualToString:JWSimpleShapeTypeArrow]) {
        _data =  @[@"50,98|1", @"50,2", @"20,36", @"50,2|1", @"80,36"];
    } else if([self.type isEqualToString:JWSimpleShapeTypeHeart]) {
        _data = @[@"50,30|1", @"8,26,28,3,10,18|2", @"11,51,5,36,6,45|2", @"50,90,20,65|3", @"89,51,80,65|3",@"92,26,94,45,95,36|2", @"50,30,90,18,72,3|2"];
    } else if([self.type isEqualToString:JWSimpleShapeTypePentastar]) {
        _data = @[@"50,5|1", @"60,39", @"95,39", @"67,60", @"77,93", @"50,73", @"23,93", @"33, 60", @"5,39", @"40,39", @"50,5"];
    } else if([self.type isEqualToString:JWSimpleShapeTypeAdd]) {
        _data = @[@"4,50|1", @"96,50", @"50,4|1", @"50,96"];
    } else if([self.type isEqualToString:JWSimpleShapeTypeClose]) {
        _data = @[@"16,16|1", @"82,82", @"84,16|1", @"18,82"];
    }
}

- (void)setLayerColor {
    _shapeLayer.strokeColor = self.tintColor.CGColor;
}

- (void)layoutLayers {
    _shapeLayer.frame = self.bounds;
    
    CGFloat layerSize = MIN(self.w, self.h);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    if (_data) {
        for (NSString *line in _data) {
            NSArray *lineGroup = [line componentsSeparatedByString:@"|"];
            JWSimpleShapeMethod method = JWSimpleShapeMethodLine;
            if (lineGroup.count == 2) {
                method = [lineGroup[1] integerValue];
            }
            NSArray *points = [lineGroup[0] componentsSeparatedByString:@","];
            if (method == JWSimpleShapeMethodMove && points.count == 2) {
                [bezierPath moveToPoint:CGPointMake(kConvertByRatio(points[0], layerSize), kConvertByRatio(points[1], layerSize))];
            } else if(method == JWSimpleShapeMethodLine && points.count == 2) {
                [bezierPath addLineToPoint:CGPointMake(kConvertByRatio(points[0], layerSize), kConvertByRatio(points[1], layerSize))];
            } else if(method == JWSimpleShapeMethodCurve && points.count == 6) {
                [bezierPath addCurveToPoint:CGPointMake(kConvertByRatio(points[0], layerSize), kConvertByRatio(points[1], layerSize))
                                       controlPoint1:CGPointMake(kConvertByRatio(points[2], layerSize), kConvertByRatio(points[3], layerSize))
                                       controlPoint2:CGPointMake(kConvertByRatio(points[4], layerSize), kConvertByRatio(points[5], layerSize))];
            } else if(method == JWSimpleShapeMethodQuadCurve && points.count == 4) {
                [bezierPath addQuadCurveToPoint:CGPointMake(kConvertByRatio(points[0], layerSize), kConvertByRatio(points[1], layerSize))
                                   controlPoint:CGPointMake(kConvertByRatio(points[2], layerSize), kConvertByRatio(points[3], layerSize))];
            } else if(method == JWSimpleShapeMethodArc) {
                
            }
        }
    }
    _shapeLayer.path = bezierPath.CGPath;
}

@end
