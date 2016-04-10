//
//  JWCircleProgressView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/22.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;
#import "JWProgressProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JWCircleProgressStyle){
    JWCircleProgressStyleDefault,
    JWCircleProgressStylePie
};

@interface JWCircleProgressView : UIView<JWProgressProtocol>

@property (assign, nonatomic) CGFloat progress;
@property (assign, nonatomic) JWCircleProgressStyle style;

@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) BOOL drawBackground;//default is YES

@end

NS_ASSUME_NONNULL_END
