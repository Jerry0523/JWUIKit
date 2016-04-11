//
//  JWPullRefreshHeaderContentView.m
//  JWUIKit
//
//  Created by 王杰 on 16/4/9.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWPullRefreshHeaderContentView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"
//View
#import "JWArrow.h"
#import "JWCircleProgressView.h"
#import "JWCircleLoadingView.h"

@implementation JWPullRefreshHeaderContentView {
    JWArrow *_arrowView;
    JWCircleProgressView *_progressView;
    JWCircleLoadingView *_loadingView;
    UILabel *_statusLabel;
}

JWUIKitInitialze {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    _arrowView = [[JWArrow alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _arrowView.center = CGPointMake(self.w * .5f, self.h * .5f - 11);
    _arrowView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _arrowView.lineWidth = 2.0f;
    _arrowView.direction = JWArrowDirectionBottom;
    _arrowView.hidden = YES;
    
    [self addSubview:_arrowView];
    
    _progressView = [[JWCircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    _progressView.drawBackground = NO;
    _progressView.center = CGPointMake(self.w * .5f, self.h * .5f - 11);
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _progressView.lineWidth = 2.0f;
    
    [self addSubview:_progressView];
    
    _loadingView = [[JWCircleLoadingView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    _loadingView.drawBackground = NO;
    _loadingView.center = CGPointMake(self.w * .5f, self.h * .5f - 11);
    _loadingView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _loadingView.style = JWCircleLoadingStyleCumulative;
    _loadingView.lineWidth = 2.0f;
    [self addSubview:_loadingView];
    
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.w, 22)];
    _statusLabel.textColor = JWColor(50, 50, 50, 1.0);
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.font = [UIFont systemFontOfSize:12.0];
    _statusLabel.center = CGPointMake(self.w * .5f, self.h * .5f + 11);
    _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:_statusLabel];
    
    self.tintColor = JWColor(249, 147, 104, 1.0);
}

#pragma mark - JWPullRefreshContentViewProtocol

- (void)setProgress:(CGFloat)progress {
    _loadingView.hidden = YES;
    
    _arrowView.hidden = NO;
    _progressView.hidden = NO;
    
    _progressView.progress = progress;
    if (progress >= 1) {
        _arrowView.direction = JWArrowDirectionTop;
        _statusLabel.text = @"Release to refresh";
    } else {
        _arrowView.direction = JWArrowDirectionBottom;
        _statusLabel.text = @"Pull to refresh";
    }
}

- (void)startLoading {
    _loadingView.hidden = NO;
    
    _arrowView.hidden = YES;
    _progressView.hidden = YES;
    
    [_loadingView startAnimating];
    _statusLabel.text = @"Refreshing";
}

- (void)stopLoading {
    _loadingView.hidden = YES;
    
    _arrowView.hidden = NO;
    _progressView.hidden = NO;
    
    [_loadingView stopAnimating];
}

- (void)loadedSuccess {
    
}

@end
