//
//  JWRadarLoadingView.h
//  JWUIKit
//
//  Created by 王杰 on 16/3/27.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWBaseLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JWRadarLoadingView : JWBaseLoadingView

@property (assign, nonatomic) CGFloat centerCircleRadiusPercent;
@property (assign, nonatomic) CGFloat ringsCount;

@property (assign, nonatomic) NSTimeInterval circleAnimationDuration;
@property (assign, nonatomic) NSTimeInterval ringAnimationDuration;

@end

NS_ASSUME_NONNULL_END
