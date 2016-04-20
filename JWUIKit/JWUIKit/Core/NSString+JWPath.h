//
//  NSString+JWPath.h
//  JWUIKit
//
//  Created by Jerry on 16/4/20.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JWPath)

- (nullable UIBezierPath*)pathForFont:(UIFont*)font;

@end

NS_ASSUME_NONNULL_END
