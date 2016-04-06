//
//  JWCircleLoadingView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWBaseLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JWCircleLoadingStyle){
    JWCircleLoadingStyleDefault      = 0,
    JWCircleLoadingStyleCumulative   = 1,
    JWCircleLoadingStyleGradient     = 2
};

@interface JWCircleLoadingView : JWBaseLoadingView

@property (assign, nonatomic) JWCircleLoadingStyle style;

@property (assign, nonatomic) CGFloat lineWidth;//default is 3.0
@property (assign, nonatomic) BOOL drawBackground;

@end

NS_ASSUME_NONNULL_END
