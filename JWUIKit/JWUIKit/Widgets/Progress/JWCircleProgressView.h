//
//  JWCircleProgressView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/22.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JWCircleProgressStyle){
    JWCircleProgressStyleDefault,
    JWCircleProgressStylePie
};

@interface JWCircleProgressView : UIView

@property (assign, nonatomic) CGFloat progress;
@property (assign, nonatomic) JWCircleProgressStyle style;

@property (assign, nonatomic) BOOL showBackground;//default is YES

@property (strong, nonatomic, nullable) UIColor *tintColor;//default is white

@end

NS_ASSUME_NONNULL_END
