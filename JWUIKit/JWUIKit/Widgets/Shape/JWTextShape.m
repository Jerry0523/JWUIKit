//
//  JWTextShape.m
//  JWUIKit
//
//  Created by Jerry on 16/4/19.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWTextShape.h"
//Core
#import "JWAlgorithm.h"
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

#import <CoreText/CoreText.h>

@implementation JWTextShape {
    CAShapeLayer *_shapeLayer;
}

JWUIKitInitialze {
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.geometryFlipped = YES;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
    
    _shapeLayer.strokeColor = self.tintColor.CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:17];
    self.contentInset = UIEdgeInsetsMake(0, 5, 5, 5);
    self.lineWidth = 1.0f;
    self.duration = 1.0f;
    
    [self.layer addSublayer:_shapeLayer];
}

- (void)layoutSubviews {
    _shapeLayer.frame = CGRectMake(self.contentInset.left, self.contentInset.top, self.w - self.contentInset.left - self.contentInset.right, self.h - self.contentInset.top - self.contentInset.bottom);
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

- (void)beginSimpleAnimation {
    [_shapeLayer removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0f);
    animation.toValue = @(1.0f);
    animation.duration = self.duration;
    [_shapeLayer addAnimation:animation forKey:nil];
}

#pragma mark - Setter & Getter
- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        [self setupLayer];
        [self invalidateIntrinsicContentSize];
    }
}

- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
        [self setupLayer];
        [self invalidateIntrinsicContentSize];
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

#pragma mark - Private
- (void)setupLayer {
    if (!self.text.length || !self.font) {
        return;
    }
    
    NSAttributedString *attrStrs = [[NSAttributedString alloc] initWithString:self.text
                                                                   attributes:@{NSFontAttributeName: self.font}];
    CGMutablePathRef paths = CGPathCreateMutable();
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrStrs);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            {
                CGPathRef path = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x + 2 * runGlyphIndex, position.y);
                CGPathAddPath(paths, &t,path);
                CGPathRelease(path);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:paths]];
    
    CGPathRelease(paths);
    _shapeLayer.path = path.CGPath;
}

@end
