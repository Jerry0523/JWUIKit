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
}

JWUIKitInitialze {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    _arrowView = [[JWArrow alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _arrowView.center = CGPointMake(self.w * .5f, self.h * .5f);
    _arrowView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _arrowView.lineWidth = 2.0f;
    _arrowView.direction = JWArrowDirectionBottom;
    
    [self addSubview:_arrowView];
    
    _progressView = [[JWCircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    _progressView.drawBackground = NO;
    _progressView.center = CGPointMake(self.w * .5f, self.h * .5f);
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _progressView.lineWidth = 2.0f;
    
    [self addSubview:_progressView];
    
    _loadingView = [[JWCircleLoadingView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    _loadingView.drawBackground = NO;
    _loadingView.center = CGPointMake(self.w * .5f, self.h * .5f);
    _loadingView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _loadingView.style = JWCircleLoadingStyleCumulative;
    _loadingView.lineWidth = 2.0f;
    [self addSubview:_loadingView];
    
    _loadingView.hidden = YES;
}

- (void)beginLoading {
    _loadingView.hidden = NO;
    
    _arrowView.hidden = YES;
    _progressView.hidden = YES;
    
    [_loadingView startAnimating];
}

- (void)stopLoading {
    _loadingView.hidden = YES;
    
    _arrowView.hidden = NO;
    _progressView.hidden = NO;
    
    [_loadingView stopAnimating];
}

#pragma mark - JWProgressProtocol
- (void)setProgress:(CGFloat)progress {
    _progressView.progress = progress;
}

@end
