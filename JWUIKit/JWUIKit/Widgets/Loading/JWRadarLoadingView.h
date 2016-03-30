//
//  JWRadarLoadingView.h
//  JWUIKit
//
//  Created by 王杰 on 16/3/27.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;
#import "JWLoadingViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JWRadarLoadingView : UIView<JWLoadingViewProtocol>

@property (assign, nonatomic) CGFloat centerCircleRadiusPercent;
@property (assign, nonatomic) CGFloat ringsCount;

@property (assign, nonatomic, readonly) BOOL isAnimating;
@property (assign, nonatomic) NSTimeInterval circleAnimationDuration;
@property (assign, nonatomic) NSTimeInterval ringAnimationDuration;

@end

NS_ASSUME_NONNULL_END
