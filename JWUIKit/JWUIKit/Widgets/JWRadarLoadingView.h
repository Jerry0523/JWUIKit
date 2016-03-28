//
//  JWRadarLoadingView.h
//  JWUIKit
//
//  Created by 王杰 on 16/3/27.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JWRadarLoadingView : UIView

@property (assign, nonatomic) CGFloat centerCircleRadiusPercent;
@property (assign, nonatomic) CGFloat ringsCount;

@property (strong, nonatomic, nullable) UIColor *tintColor;

@property (assign, nonatomic, readonly) BOOL isAnimating;
@property (assign, nonatomic) NSTimeInterval circleAnimationDuration;
@property (assign, nonatomic) NSTimeInterval ringAnimationDuration;

- (void)startAnimating;
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
