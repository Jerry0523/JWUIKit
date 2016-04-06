//
//  JWDotCircleLoadingView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/31.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWBaseLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JWDotLoadingStyle){
    JWDotLoadingStyleCircle   = 0,
    JWDotLoadingStyleLine     = 1
};

@interface JWDotLoadingView : JWBaseLoadingView

@property (assign, nonatomic) JWDotLoadingStyle style;

@property (assign, nonatomic) NSUInteger dotCount;//default is 5

@end

NS_ASSUME_NONNULL_END
