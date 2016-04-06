//
//  UIView+JWFrame.h
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

@interface UIView (JWFrame)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat w;
@property (assign, nonatomic) CGFloat h;

@property (assign, nonatomic, readonly) CGFloat maxX;
@property (assign, nonatomic, readonly) CGFloat maxY;

- (void)originToPoint:(CGPoint)point;

- (void)makeTranslateForX:(CGFloat)x y:(CGFloat)y;

@end
