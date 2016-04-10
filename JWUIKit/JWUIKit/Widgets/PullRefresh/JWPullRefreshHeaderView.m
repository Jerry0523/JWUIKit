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
@property (weak, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (assign, nonatomic) UIEdgeInsets scrollViewOriginalInset;

@end

@implementation JWPullRefreshHeaderView

JWUIKitInitialze {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor lightGrayColor];
    self.clipsToBounds = YES;
    
    self.contentView = [[JWPullRefreshHeaderContentView alloc] initWithFrame:CGRectMake(0, self.h - 80, self.w, 80)];
    [self addSubview:self.contentView];
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    [self removeKVO];
    if (newSuperview) {
        self.scrollView = (id)newSuperview;
        self.scrollViewOriginalInset = self.scrollView.contentInset;
        self.panGestureRecognizer = self.scrollView.panGestureRecognizer;
        [self registKVO];
    }
}

#pragma mark - KVO
- (void)registKVO {
    [self.scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if([keyPath isEqualToString:@"state"]) {
        [self scrollViewPanGestureStateDidChange:change];
    } else if([keyPath isEqualToString:@"contentInset"]) {
        [self scrollViewContentInsetDidChange:change];
    }
}

- (void)removeKVO {
    [self.superview removeObserver:self forKeyPath:@"contentInset"];
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [self.panGestureRecognizer removeObserver:self forKeyPath:@"state"];
    self.panGestureRecognizer = nil;
}

#pragma mark - Setter & Getter
- (void)setState:(JWPullRefreshState)state {
    if (_state != state) {
        _state = state;
        switch (state) {
            case JWPullRefreshStateDefault: {
                [self.contentView stopLoading];
                [self.scrollView removeObserver:self forKeyPath:@"contentInset"];
                [UIView animateWithDuration:0.25f animations:^{
                    self.scrollView.contentInset = self.scrollViewOriginalInset;
                    
                    CGPoint newOffset = self.scrollView.contentOffset;
                    newOffset.y = - self.scrollViewOriginalInset.top;
                    self.scrollView.contentOffset = newOffset;
                    
                } completion:^(BOOL finished) {
                    [self.scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
                }];
            }
                break;
            case JWPullRefreshStateRefreshing: {
                [self.contentView beginLoading];
                [self.scrollView removeObserver:self forKeyPath:@"contentInset"];
                [UIView animateWithDuration:0.25f animations:^{
                    
                    UIEdgeInsets newInset = UIEdgeInsetsMake(_scrollViewOriginalInset.top + 80, _scrollViewOriginalInset.left, _scrollViewOriginalInset.bottom, _scrollViewOriginalInset.right);
                    self.scrollView.contentInset = newInset;
                    
                    CGPoint newOffset = self.scrollView.contentOffset;
                    newOffset.y = - newInset.top;
                    self.scrollView.contentOffset = newOffset;
                } completion:^(BOOL finished) {
                    [self.scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.state = JWPullRefreshStateDefault;
                    });
                }];
            }
                break;
        }
    }
}

#pragma mark - Private
- (void)scrollViewContentOffsetDidChange:(NSDictionary*)change {
    CGFloat offsetY = -self.scrollView.contentOffset.y - self.scrollViewOriginalInset.top;
    if (offsetY < 0) {
        return;
    }
    
    self.frame = CGRectMake(0, -offsetY, self.scrollView.w,  offsetY);
    [self.contentView setProgress:self.h / 120.0f];
}

- (void)scrollViewContentInsetDidChange:(NSDictionary*)change {
    self.scrollViewOriginalInset = self.scrollView.contentInset;
}

- (void)scrollViewPanGestureStateDidChange:(NSDictionary*)change {
    if (self.scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.state == JWPullRefreshStateRefreshing) {
            return;
        }
         CGFloat offsetY = - (self.scrollView.contentInset.top + self.scrollView.contentOffset.y);
        if (offsetY >= 120) {
            self.state = JWPullRefreshStateRefreshing;
        } else {
            self.state = JWPullRefreshStateDefault;
        }
    }
}


@end
