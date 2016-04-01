//
//  JWDotCircleLoadingView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/31.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWLoadingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JWDotLoadingStyle){
    JWDotLoadingStyleCircle   = 0,
    JWDotLoadingStyleLine     = 1
};

@interface JWDotLoadingView : UIView<JWLoadingProtocol>

@property (assign, nonatomic, readonly) BOOL isAnimating;
@property (assign, nonatomic) JWDotLoadingStyle style;

@property (assign, nonatomic) NSUInteger dotCount;//default is 5

@end

NS_ASSUME_NONNULL_END
