//
//  JWFoldawayDrawer.m
//  JWUIKit
//
//  Created by 王杰 on 16/4/15.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWFoldawayDrawer.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWFoldawayDrawer {
    UIColor *_containerBackgroundColor;
}

JWUIKitInitialze {
    self.duration = 0.6f;
    self.autoLayoutSuperView = YES;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize intrisicContentSize = [self intrinsicContentSize];
    return CGSizeMake(size.width, intrisicContentSize.height);
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [self.subviews lastObject].maxY);
    
}

- (void)open {
    _isOpen = YES;
    NSUInteger sectionCount = [self.dataSource numberOfViews];
    if (sectionCount <= 1) {
        return;
    }
    [self appendSectionAnimated];
}

- (void)close {
    _isOpen = NO;
    NSUInteger sectionCount = self.subviews.count;
    if (sectionCount <= 1) {
        return;
    }
    [self removeSectionAnimated];
}

- (void)toggle {
    if (_isOpen) {
        [self close];
    } else {
        [self open];
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    if (_isOpen) {
        [self appendSectionAnimated];
    } else {
        UIView *lastContainer = self.subviews.lastObject;
        [lastContainer removeFromSuperview];
        [self notifySizeChanged];
        
        [self removeSectionAnimated];
    }
}

#pragma mark - Setter & Getter
- (void)setDataSource:(id<JWFoldawayDrawerDataSource>)dataSource {
    _dataSource = dataSource;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = [dataSource numberOfViews];
    if (count > 0) {
        [self addSubview:[self createContainerAtIndex:0]];
    }
    [self notifySizeChanged];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
    for (UIView *subView in self.subviews) {
        subView.backgroundColor = backgroundColor;
    }
    _containerBackgroundColor = backgroundColor;
}

#pragma mark - Private
- (void)appendSectionAnimated {
    NSUInteger currentIdx = self.subviews.count;
    NSUInteger sectionCount = [self.dataSource numberOfViews];
    if (currentIdx == sectionCount) {
        return;
    }
    
    UIView *lastContainer = self.subviews.lastObject;
    
    UIView *nextContainer = [self createContainerAtIndex:currentIdx];
    nextContainer.layer.anchorPoint = CGPointMake(0.5, 0);
    [nextContainer originToPoint:CGPointMake(0, lastContainer.maxY)];
    [self addSubview:nextContainer];
    
    [self notifySizeChanged];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(drawer:willOpenIndex:)]) {
        [self.delegate drawer:self willOpenIndex:currentIdx];
    }
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DMakeTranslation(0, 0, 100), M_PI, 1, 0, 0)];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.duration = self.duration;
    transformAnimation.delegate = self;
    [nextContainer.layer addAnimation:transformAnimation forKey:nil];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = @(0);
    fadeAnimation.toValue = @(1);
    fadeAnimation.duration = self.duration;
    [[nextContainer.subviews firstObject].layer addAnimation:fadeAnimation forKey:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(drawer:didOpenIndex:)]) {
        [self.delegate drawer:self didOpenIndex:currentIdx];
    }
}

- (void)removeSectionAnimated {
    NSUInteger currentIdx = self.subviews.count;
    if (currentIdx <= 1) {
        return;
    }
    
    UIView *lastContainer = self.subviews.lastObject;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(drawer:willCloseIndex:)]) {
        [self.delegate drawer:self willCloseIndex:currentIdx];
    }
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DMakeTranslation(0, 0, 100), M_PI, 1, 0, 0)];
    transformAnimation.duration = self.duration;
    transformAnimation.delegate = self;
    [lastContainer.layer addAnimation:transformAnimation forKey:nil];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = @(1);
    fadeAnimation.toValue = @(0);
    fadeAnimation.duration = self.duration;
    [[lastContainer.subviews firstObject].layer addAnimation:fadeAnimation forKey:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(drawer:didCloseIndex:)]) {
        [self.delegate drawer:self didOpenIndex:currentIdx];
    }
}

- (UIView*)createContainerAtIndex:(NSUInteger)idx {
    UIView *container = [UIView new];
    UIView *contentView = [self.dataSource viewAtIndex:idx];
    
    container.w = self.w;
    contentView.w = self.w;
    
    if ([self.dataSource respondsToSelector:@selector(heightOfViewAtIndex:)]) {
        CGFloat viewHeight = [self.dataSource heightOfViewAtIndex:idx];
        container.h = viewHeight;
        contentView.h = viewHeight;
    } else {
        container.h = contentView.h;
    }
    
    container.backgroundColor = _containerBackgroundColor;
    container.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [container addSubview:contentView];
    return container;
}

- (void)notifySizeChanged {
    if (!self.autoLayoutSuperView) {
        [self invalidateIntrinsicContentSize];
        return;
    }
    
    UIView *superView = self.superview;
    while (![superView isKindOfClass:[UITableView class]] && superView.superview) {
        superView = superView.superview;
    }
    
    BOOL isSuperViewTableView = [superView isKindOfClass:[UITableView class]];
    
    if (isSuperViewTableView) {
        UITableView *tableView = superView;
        [tableView beginUpdates];
        [self invalidateIntrinsicContentSize];
        [tableView endUpdates];
    } else {
        [self invalidateIntrinsicContentSize];
        [UIView animateWithDuration:self.duration animations:^{
            [self.superview layoutIfNeeded];
        }];
    }
}


@end
