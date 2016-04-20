//
//  JWAnimatedLabel.m
//  JWUIKit
//
//  Created by Jerry on 16/4/19.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWAnimatedLabel.h"
//Core
#import "JWAlgorithm.h"
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"
#import "NSString+JWPath.h"

@implementation JWAnimatedLabel {
    CAShapeLayer *_shapeLayer;
    CAGradientLayer *_gradientLayer;
}

JWUIKitInitialze {
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.geometryFlipped = YES;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
    
    _shapeLayer.strokeColor = self.tintColor.CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.fontSize = 17;
    self.fontName = @"HelveticaNeue-UltraLight";
    
    self.lineWidth = 1.0f;
    self.duration = 1.0f;
    
    [self.layer addSublayer:_shapeLayer];
}

- (void)layoutSubviews {
    CGFloat layerWidth = self.w - self.contentInset.left - self.contentInset.right;
    CGFloat layerHeight = self.h - self.contentInset.top - self.contentInset.bottom;
    _shapeLayer.frame = CGRectMake(self.contentInset.left,
                                   self.contentInset.top + self.font.descender,
                                   layerWidth,
                                   layerHeight);
}

- (CGSize)intrinsicContentSize {
    if (!self.text.length || !self.font) {
        return CGSizeZero;
    }
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    return CGSizeMake(size.width + self.contentInset.left + self.contentInset.right + _text.length * 2, size.height + self.contentInset.top + self.contentInset.bottom);
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}

- (void)tintColorDidChange {
    _shapeLayer.strokeColor = self.tintColor.CGColor;
}

- (void)startAnimating {
    [_shapeLayer removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0f);
    animation.toValue = @(1.0f);
    animation.duration = self.duration;
    animation.repeatCount = self.repeat ? INFINITY : 0;
    [_shapeLayer addAnimation:animation forKey:nil];
}

#pragma mark - Setter & Getter
- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        [self setupLayer];
        [self invalidateIntrinsicContentSize];
        [self startAnimating];
    }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    if(!UIEdgeInsetsEqualToEdgeInsets(_contentInset, contentInset)) {
        _contentInset = contentInset;
        [self invalidateIntrinsicContentSize];
    }
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        _shapeLayer.lineWidth = lineWidth;
    }
}

- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
        [self setupLayer];
        [self invalidateIntrinsicContentSize];
    }
}

- (void)setFontSize:(CGFloat)fontSize {
    if (_fontSize != fontSize) {
        _fontSize = fontSize;
        if (self.fontName) {
            self.font = [UIFont fontWithName:self.fontName size:fontSize];
        }
    }
}

- (void)setFontName:(NSString *)fontName {
    if (_fontName != fontName) {
        _fontName = fontName;
        if (self.fontSize > 0) {
            self.font = [UIFont fontWithName:fontName size:self.fontSize];
        }
    }
}

#pragma mark - Private
- (void)setupLayer {
    UIBezierPath *path = [self.text pathForFont:self.font];
    if (path) {
        _shapeLayer.path = path.CGPath;
    }
}

@end
