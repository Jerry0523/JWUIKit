//
//  JWAnimatedImageView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JWAnimatedImageViewAnimation){
    JWAnimatedImageViewAnimationNone,
    JWAnimatedImageViewAnimationFade,
    JWAnimatedImageViewAnimationZoom,
    JWAnimatedImageViewAnimationLeft,
    JWAnimatedImageViewAnimationRollOver,
    JWAnimatedImageViewAnimationBlur
};

@interface JWAnimatedImageView : UIView

@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (strong, nonatomic, nullable) UIImage *image;// set the image of imageView. Animated.

@property (assign, nonatomic) JWAnimatedImageViewAnimation animationStyle;
@property (strong, nonatomic, nullable) CABasicAnimation *customAnimation;//if set, animationStyle will be ignored.
@property (assign, nonatomic) NSTimeInterval duration;//default is 0.5

- (void)beginAnimation;

@end

NS_ASSUME_NONNULL_END
