//
//  JWRefreshHeaderView.m
//  JWUIKit
//
//  Created by Jerry on 16/4/8.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWRefreshHeaderView.h"
#import "JWRefreshHeaderContentView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@interface JWRefreshHeaderView()

@property (weak, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) UIEdgeInsets scrollViewOriginalInset;
@property (weak, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@property (assign, nonatomic) JWPullRefreshState state;
@property (strong, nonatomic) UIView<JWRefreshContentViewProtocol> *contentView;


@end

@implementation JWRefreshHeaderView

JWUIKitInitialze {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.clipsToBounds = YES;
    self.backgroundColor = JWColor(230, 230, 230, 1.0);
}

+ (instancetype)headerWithRefreshingBlock:(JWRefreshingBlock)refreshingBlock {
    JWRefreshHeaderView *refreshView = [JWRefreshHeaderView new];
    refreshView.refreshingBlock = refreshingBlock;
    return refreshView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    if (!self.contentView) {
        self.contentViewClass = NSStringFromClass([JWRefreshHeaderContentView class]);
    }
    [self removeKVO];
    if (newSuperview) {
        self.contentView.tintColor = self.tintColor;
        self.scrollView = (id)newSuperview;
        self.scrollViewOriginalInset = self.scrollView.contentInset;
        self.panGestureRecognizer = self.scrollView.panGestureRecognizer;
        [self registKVO];
    }
}

#pragma mark - Public
- (void)startRefreshing {
    self.state = JWPullRefreshStateRefreshing;
}

- (void)endRefreshing {
    [self endRefreshingWithDelay:0];
}

- (void)endRefreshingWithDelay:(NSTimeInterval)delay {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(didEndRefreshing) withObject:nil afterDelay:delay];
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
- (void)setContentView:(UIView<JWRefreshContentViewProtocol> *)contentView {
    if (_contentView != contentView) {
        [_contentView removeFromSuperview];
        _contentView = contentView;
        [self addSubview:self.contentView];
        [self setupContentViewByStyleChange];
    }
}

- (void)setContentViewClass:(NSString *)contentViewClass {
    if (![_contentViewClass isEqualToString:contentViewClass]) {
        _contentViewClass = contentViewClass;
        Class contentViewCls = NSClassFromString(contentViewClass);
        if (contentViewCls) {
            self.contentView = [[contentViewCls alloc] initWithFrame:CGRectMake(0, 0, self.w, [contentViewCls preferredHeight])];
        }
    }
}

- (void)setStyle:(JWPullRefreshStyle)style {
    _style = style;
    [self setupContentViewByStyleChange];
}

- (void)setState:(JWPullRefreshState)state {
    if (_state != state) {
        _state = state;
        switch (state) {
            case JWPullRefreshStateIdle: {
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
                [self.contentView startLoading];
                [self.scrollView removeObserver:self forKeyPath:@"contentInset"];
                [UIView animateWithDuration:0.25f animations:^{
                    
                    UIEdgeInsets newInset = UIEdgeInsetsMake(_scrollViewOriginalInset.top + self.contentView.h, _scrollViewOriginalInset.left, _scrollViewOriginalInset.bottom, _scrollViewOriginalInset.right);
                    self.scrollView.contentInset = newInset;
                    
                    CGPoint newOffset = self.scrollView.contentOffset;
                    newOffset.y = - newInset.top;
                    
                    self.scrollView.contentOffset = newOffset;
                } completion:^(BOOL finished) {
                    [self.scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
                    if (self.refreshingBlock) {
                        self.refreshingBlock();
                    }
                }];
            }
                break;
        }
    }
}

#pragma mark - Private
- (void)setupContentViewByStyleChange {
    CGFloat viewHeight = [self.contentView.class preferredHeight];
    if (self.style == JWPullRefreshStyleStill) {
        self.contentView.frame = CGRectMake(0, 0, self.w, viewHeight);
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    } else if(self.style == JWPullRefreshStyleFollow) {
        self.contentView.frame = CGRectMake(0, self.h - viewHeight, self.w, viewHeight);
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
}

- (void)didEndRefreshing {
    self.state = JWPullRefreshStateIdle;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary*)change {
    CGFloat offsetY = -self.scrollView.contentOffset.y - self.scrollViewOriginalInset.top;
    if (offsetY < 0) {
        return;
    }
    self.frame = CGRectMake(0, -offsetY, self.scrollView.w,  offsetY);
    if (self.state == JWPullRefreshStateIdle) {
        [self.contentView setProgress:self.h / self.contentView.h];
    }
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
        if (offsetY >= self.contentView.h) {
            self.state = JWPullRefreshStateRefreshing;
        } else {
            self.state = JWPullRefreshStateIdle;
        }
    }
}

@end
