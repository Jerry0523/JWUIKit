//
//  JWPageControl.m
//  JWUIKit
//
//  Created by Jerry on 16/4/7.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWPageControl.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWPageControl

JWUIKitInitialze {
    
}

#pragma mark - Setter & Getter
- (void)setActiveImage:(UIImage *)activeImage {
    if (_activeImage != activeImage) {
        _activeImage = activeImage;
    }
}

- (void)setInactiveImage:(UIImage *)inactiveImage {
    if (_inactiveImage != inactiveImage) {
        _inactiveImage = inactiveImage;
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    [self setupCustomStyleByImage];
    [self highlightCustomStylePageValueChange];
}

#pragma mark - Private
- (void)setupCustomStyleByImage {
    if (self.activeImage || self.inactiveImage) {
        [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL * stop) {
            if (subView.subviews.count == 0) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:self.inactiveImage highlightedImage:self.activeImage];
                imageView.frame = subView.bounds;
                imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [subView addSubview:imageView];
            }
        }];
    }
}

- (void)highlightCustomStylePageValueChange {
    if (self.activeImage || self.inactiveImage) {
        [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL * stop) {
            NSArray *subArray = subView.subviews;
            if (subArray.count > 0) {
                UIImageView *dotImage = [subArray firstObject];
                if ([dotImage isKindOfClass:[UIImageView class]]) {
                    dotImage.highlighted = idx == self.currentPage;
                }
            }
            
            if (idx == self.currentPage) {
                if (self.activeImage) {
                    subView.backgroundColor = [UIColor clearColor];
                } else {
                    subView.backgroundColor = self.currentPageIndicatorTintColor ? :[UIColor colorWithWhite:0 alpha:.3];
                }
            } else {
                if (self.inactiveImage) {
                    subView.backgroundColor = [UIColor clearColor];
                } else {
                    subView.backgroundColor = self.pageIndicatorTintColor ? :[UIColor colorWithWhite:0 alpha:.1];
                }
            }
        }];
    }
}

@end
