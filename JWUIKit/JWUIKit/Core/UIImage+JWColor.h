//
//  UIImage+JWColor.h
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

@interface UIImage (JWColor)

+ (UIImage*)imageWithColor:(UIColor*)color;
+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIColor*)mainColor;

@end
