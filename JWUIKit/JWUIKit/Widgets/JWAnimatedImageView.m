//
//  JWAnimatedImageView.m
//  JWUIKit
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWAnimatedImageView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+Frame.h"

@interface JWAnimatedImageView()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation JWAnimatedImageView

JWUIKitInitialze {
    [self addSubview:self.imageView];
    self.duration = 0.5f;
}

- (void)sizeToFit {
    [self.imageView sizeToFit];
    self.w = self.imageView.w;
    self.h = self.imageView.h;
}

- (CGSize)sizeThatFits:(CGSize)size{
    return [self.imageView sizeThatFits:size];
}

#pragma mark - Public
- (void)beginAnimation {
    [self.imageView.layer removeAllAnimations];
    CABasicAnimation *animation;
    if (self.customAnimation) {
        animation = self.customAnimation;
    } else {
        switch (self.animationStyle) {
            case JWAnimatedImageViewAnimationFade: {
                animation = [self fadeAnimation];
                break;
            }
                
            case JWAnimatedImageViewAnimationZoom: {
                animation = [self zoomAnimation];
                break;
            }
                
            case JWAnimatedImageViewAnimationLeft: {
                animation = [self leftAnimation];
                break;
            }
                
            case JWAnimatedImageViewAnimationRollOver: {
                animation = [self rollOverAnimation];
                break;
            }
                
            case JWAnimatedImageViewAnimationBlur: {
                animation = nil;
                [self beginBlurAnimation];
                break;
            }
                
            default:
                animation = nil;
                break;
        }
    }
    if (animation) {
        [self.imageView.layer addAnimation:animation forKey:nil];
    }
}

#pragma mark - Getter & Setter
- (UIImageView*)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self beginAnimation];
}

- (UIImage*)image {
    return self.imageView.image;
}

#pragma mark - Animations
- (CABasicAnimation*)fadeAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = self.duration;
    animation.fromValue = @(.0f);
    animation.toValue = @(1.0f);
    return animation;
}

- (CABasicAnimation*)zoomAnimation {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform"];
    animation.duration = self.duration;
    animation.damping = 16.0;
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    return animation;
}

- (CABasicAnimation*)leftAnimation {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform"];
    animation.duration = self.duration;
    animation.damping = 16.0;
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.w, 0, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    return animation;
}

- (CABasicAnimation*)rollOverAnimation {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform"];
    animation.duration = self.duration;
    animation.damping = 16.0;
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI , 0, 1, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    return animation;
}

- (void)beginBlurAnimation {
    
}

@end
