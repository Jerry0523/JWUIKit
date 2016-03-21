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
#import "UIView+JWFrame.h"
#import "UIImage+JWSub.h"

@interface JWAnimatedImageView()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIVisualEffectView *effectView;


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
                
            case JWAnimatedImageViewAnimationBox: {
                animation = nil;
                [self beginBoxAnimation];
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

- (UIVisualEffectView*)effectView {
    if (!_effectView) {
        _effectView = [UIVisualEffectView new];
        _effectView.frame = self.bounds;
        _effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _effectView;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    if (!self.disableActions) {
        [self beginAnimation];
    }
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
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = self.duration;
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI , 0, 1, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    return animation;
}

- (void)beginBlurAnimation {
    if (!self.effectView.superview) {
        [self addSubview:self.effectView];
    }
    self.effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    [UIView animateWithDuration:self.duration animations:^{
        self.effectView.effect = nil;
    } completion:^(BOOL finished) {
        [self.effectView removeFromSuperview];
    }];
}

- (void)beginBoxAnimation {
    UIImage *sourceImage = self.imageView.image;
    if (!sourceImage) {
        return;
    }
    self.imageView.hidden = YES;
    
    CGFloat sliceWidth = round(self.imageView.w / 3.0);
    CGFloat sliceHeight = round(self.imageView.h / 3.0);
    
    NSMutableArray *slicesSourceRectArray = @[].mutableCopy;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            CGRect sliceRect = CGRectMake(i * sliceWidth, j * sliceHeight, sliceWidth, sliceHeight);
            [slicesSourceRectArray addObject:[NSValue valueWithCGRect:sliceRect]];
        }
    }
    NSArray *indexArray = @[@(0), @(1), @(2), @(5), @(8), @(7), @(6), @(3), @(4)];
    NSMutableArray *slicesRectArray = @[].mutableCopy;
    for (NSNumber *idx in indexArray) {
        [slicesRectArray addObject:slicesSourceRectArray[idx.integerValue]];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *imagesArray = @[].mutableCopy;
        for (NSValue *rectValue in slicesRectArray) {
            UIImage *subImage = [sourceImage getSubImage:rectValue.CGRectValue];
            [imagesArray addObject:subImage];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [imagesArray enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                imageView.frame = [slicesRectArray[idx] CGRectValue];
                [self addSubview:imageView];
            }];
        });
    });
}

@end
