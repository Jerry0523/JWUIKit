//
//  JWCamaraMaskView.m
//  JWUIKit
//
//  Created by 王杰 on 16/4/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWCamaraMaskView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWCamaraMaskView {
    CAGradientLayer *_animatedLayer;
}

JWUIKitInitialze {
    self.emptyWidth = 220;
    self.tintLineLength = 16;
    self.tintLineWidth = 4;
    self.backgroundColor = [UIColor clearColor];
    
    _animatedLayer = [CAGradientLayer layer];
    _animatedLayer.startPoint = CGPointMake(0, .5);
    _animatedLayer.endPoint = CGPointMake(1.0, .5);
    [self tintColorDidChange];
    [self.layer addSublayer:_animatedLayer];
}

- (void)didMoveToSuperview {
    if (!_animatedLayer.superlayer) {
        [self.layer addSublayer:_animatedLayer];
    }
    [self layoutIfNeeded];
    [_animatedLayer removeAllAnimations];
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, self.emptyWidth - 4, 0)];
    transformAnimation.repeatCount = INFINITY;
    transformAnimation.duration = 2.5;
    [_animatedLayer addAnimation:transformAnimation forKey:nil];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [_animatedLayer removeFromSuperlayer];
        [_animatedLayer removeAllAnimations];
    }
}

- (void)tintColorDidChange {
    _animatedLayer.shadowColor = self.tintColor.CGColor;
    _animatedLayer.colors = @[(id)[self.tintColor colorWithAlphaComponent:0].CGColor, (id)self.tintColor.CGColor, (id)[self.tintColor colorWithAlphaComponent:0].CGColor];
}

- (void)layoutSubviews {
    CGRect emptyRect = [self emptyRect];
    _animatedLayer.frame = CGRectMake(emptyRect.origin.x, emptyRect.origin.y, self.emptyWidth, 4);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0 alpha:0.4].CGColor);
    CGContextFillRect(context, rect);
    
    CGRect emptyRect = [self emptyRect];
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextFillRect(context, emptyRect);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextStrokeRect(context, emptyRect);
    
    CGContextSetLineWidth(context, self.tintLineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
    
    CGContextMoveToPoint(context, emptyRect.origin.x, emptyRect.origin.y + self.tintLineLength);
    CGContextAddLineToPoint(context, emptyRect.origin.x, emptyRect.origin.y);
    CGContextAddLineToPoint(context, emptyRect.origin.x + self.tintLineLength, emptyRect.origin.y);
    
    CGContextMoveToPoint(context, emptyRect.origin.x, emptyRect.origin.y + emptyRect.size.height - self.tintLineLength);
    CGContextAddLineToPoint(context, emptyRect.origin.x, emptyRect.origin.y + emptyRect.size.height);
    CGContextAddLineToPoint(context, emptyRect.origin.x + self.tintLineLength, emptyRect.origin.y + emptyRect.size.height);
    
    CGContextMoveToPoint(context, emptyRect.origin.x + emptyRect.size.width - self.tintLineLength, emptyRect.origin.y);
    CGContextAddLineToPoint(context, emptyRect.origin.x + emptyRect.size.width, emptyRect.origin.y);
    CGContextAddLineToPoint(context, emptyRect.origin.x + emptyRect.size.width, emptyRect.origin.y + self.tintLineLength);
    
    CGContextMoveToPoint(context, emptyRect.origin.x + emptyRect.size.width - self.tintLineLength, emptyRect.origin.y + emptyRect.size.height);
    CGContextAddLineToPoint(context, emptyRect.origin.x + emptyRect.size.width, emptyRect.origin.y + emptyRect.size.height);
    CGContextAddLineToPoint(context, emptyRect.origin.x + emptyRect.size.width, emptyRect.origin.y + emptyRect.size.height - self.tintLineLength);
    
    CGContextStrokePath(context);
    
}

- (CGRect)emptyRect {
    return CGRectIntegral(CGRectMake((self.w - self.emptyWidth) * .5, (self.h - self.emptyWidth) * .5, self.emptyWidth, self.emptyWidth));
    ;
}

#pragma mark - Setter & Getter
- (void)setEmptyWidth:(CGFloat)emptyWidth {
    if (_emptyWidth != emptyWidth) {
        _emptyWidth = emptyWidth;
        [self setNeedsLayout];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
}

@end
