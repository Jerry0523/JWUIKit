//
//  UIView+JWFrame.m
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "UIView+JWFrame.h"

@implementation UIView (JWFrame)

- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)w {
    return CGRectGetWidth(self.frame);
}

- (void)setW:(CGFloat)w {
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

- (CGFloat)h {
    return CGRectGetHeight(self.frame);
}

- (void)setH:(CGFloat)h {
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)originToPoint:(CGPoint)point{
    CGRect frame = self.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    self.frame = frame;
}

- (void)makeTranslateForX:(CGFloat)x y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.x += x;
    frame.origin.y += y;
    self.frame = frame;
}

@end
