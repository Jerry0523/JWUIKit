//
//  JWAnimatedImageView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JWAnimatedImageViewAnimation){
    JWAnimatedImageViewAnimationNone,
    JWAnimatedImageViewAnimationFade,
    JWAnimatedImageViewAnimationRollOver,
    JWAnimatedImageViewAnimationZoom,
    JWAnimatedImageViewAnimationLeft,
    JWAnimatedImageViewAnimationBlur,
    JWAnimatedImageViewAnimationBox
};

@interface JWAnimatedImageView : UIView

@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (strong, nonatomic, nullable) UIImage *image;// set the image of imageView. Animated.

@property (assign, nonatomic) JWAnimatedImageViewAnimation animationStyle;
@property (strong, nonatomic, nullable) CABasicAnimation *customAnimation;//if set, animationStyle will be ignored.
@property (assign, nonatomic) NSTimeInterval duration;//default is 0.6

@property (assign, nonatomic) BOOL disableActions;//default is NO. By default, animation will be auto played.

- (void)beginAnimation;

@end

NS_ASSUME_NONNULL_END
