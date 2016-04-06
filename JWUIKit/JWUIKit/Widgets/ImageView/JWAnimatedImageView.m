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
#import "JWAlgorithm.h"
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
    
    int pieceOfSlices = 3;
    
    CGFloat sliceWidth = round(self.imageView.w / pieceOfSlices);
    CGFloat sliceHeight = round(self.imageView.h / pieceOfSlices);
    CGFloat radio = CGImageGetWidth(self.imageView.image.CGImage) / self.imageView.w;
    
    NSMutableArray *slicesSourceRectArray = @[].mutableCopy;
    for (int i = 0; i < pieceOfSlices; i++) {
        for (int j = 0; j < pieceOfSlices; j++) {
            CGRect sliceRect = CGRectMake(j * sliceWidth, i * sliceHeight, sliceWidth, sliceHeight);
            [slicesSourceRectArray addObject:[NSValue valueWithCGRect:sliceRect]];
        }
    }
    int *indexArray = JWCircleIndex(pieceOfSlices, pieceOfSlices);
    NSMutableArray *slicesRectArray = @[].mutableCopy;
    int piecesCount = pieceOfSlices * pieceOfSlices;
    for (int i = 0; i < piecesCount; i++) {
        [slicesRectArray addObject:slicesSourceRectArray[indexArray[i]]];
    }
    free(indexArray);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *imagesArray = @[].mutableCopy;
        for (NSValue *rectValue in slicesRectArray) {
            CGRect sliceRect = rectValue.CGRectValue;
            CGRect subRect = CGRectMake(sliceRect.origin.x * radio, sliceRect.origin.y * radio, sliceRect.size.width * radio, sliceRect.size.height * radio);
            UIImage *subImage = [sourceImage getSubImage:subRect];
            [imagesArray addObject:subImage];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *sliceContainer = [[UIView alloc] initWithFrame:self.bounds];
            sliceContainer.clipsToBounds = YES;
            [self addSubview:sliceContainer];
            
            CABasicAnimation *fadeAnimation = [self fadeAnimation];
            NSTimeInterval itemDuration = .15f;
            CFTimeInterval currentMediaTime = CACurrentMediaTime();
            
            [imagesArray enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                imageView.alpha = 0;
                imageView.frame = [slicesRectArray[idx] CGRectValue];
                [sliceContainer addSubview:imageView];
                [CATransaction begin];
                CABasicAnimation *mAnimation = fadeAnimation.copy;
                mAnimation.beginTime = currentMediaTime + itemDuration * idx;
                mAnimation.duration = itemDuration;
                mAnimation.fillMode = kCAFillModeForwards;
                mAnimation.removedOnCompletion = NO;
                [imageView.layer addAnimation:mAnimation forKey:nil];
                [CATransaction commit];
            }];
            
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, itemDuration * imagesArray.count * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [sliceContainer removeFromSuperview];
                self.imageView.hidden = NO;
            });
        });
    });
}

@end
