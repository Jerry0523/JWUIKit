//
//  JWCircleLoadingView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;
#import "JWLoadingViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JWCircleLoadingView : UIView<JWLoadingViewProtocol>

@property (strong, nonatomic, nullable) UIColor *tintColor;
@property (assign, nonatomic, readonly) BOOL isAnimating;

@end

NS_ASSUME_NONNULL_END
