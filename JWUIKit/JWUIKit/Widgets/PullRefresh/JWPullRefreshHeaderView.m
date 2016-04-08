//
//  JWPullRefreshHeaderView.m
//  JWUIKit
//
//  Created by Jerry on 16/4/8.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWPullRefreshHeaderView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@interface JWPullRefreshHeaderView()

@property (weak, nonatomic) UIScrollView *scrollView;

@end

@implementation JWPullRefreshHeaderView

JWUIKitInitialze {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor blackColor];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    [self removeKVO];
    if (newSuperview) {
        self.scrollView = newSuperview;
        [self registKVO];
    }
}

#pragma mark - KVO
- (void)registKVO {
    [self.scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentInset"]) {
        [self layoutByScrollViewChangeStatus];
    } else if([keyPath isEqualToString:@"contentOffset"]) {
        [self layoutByScrollViewChangeStatus];
    }
}

- (void)removeKVO {
    [self.superview removeObserver:self forKeyPath:@"contentInset"];
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - Private
- (void)layoutByScrollViewChangeStatus {
    CGFloat contentInsetTop = self.scrollView.contentInset.top;
    self.frame = CGRectMake(0, self.scrollView.contentInset.top - 60, self.scrollView.w, 60);
    NSLog(@"%f", self.scrollView.contentOffset.y);
}


@end
