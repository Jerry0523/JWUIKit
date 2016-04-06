//
//  JWToast.m
//  JWUIKit
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWToast.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWToast {
    UILabel *_textLabel;
}

const CGFloat padding = 10.0f;
const CGFloat margin = 30.0f;

JWUIKitInitialze {
    _textLabel = [UILabel new];
    _textLabel.numberOfLines = 0;
    _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.font = [UIFont systemFontOfSize:16.0];
    
    [self addSubview:_textLabel];
    
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.backgroundColor = [UIColor colorWithWhite:.0 alpha:.8f];
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (self.superview) {
        _textLabel.preferredMaxLayoutWidth = self.superview.w - padding * 2 - margin * 2;
        CGSize textSize = _textLabel.intrinsicContentSize;
        return CGSizeMake(textSize.width + padding * 2, textSize.height + padding * 2);
    }
    return [super sizeThatFits:size];
}

+ (instancetype)makeToast:(NSString *)msg {
    static dispatch_once_t once;
    static JWToast * _singleton;
    dispatch_once(&once, ^{
        _singleton = [[self alloc] init];
    });
    _singleton->_textLabel.text = msg;
    if (_singleton.superview) {
        [_singleton removeFromSuperview];
    }
    return _singleton;
}

- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow];
}

- (void)showInView:(UIView*)view {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [view addSubview:self];
    [self sizeToFit];
    _textLabel.frame = CGRectMake(padding, padding, self.w - padding * 2, self.h - padding * 2);
    self.center = CGPointMake(view.w * .5f, view.h - margin - self.h * .5f);
    
    self.alpha = .0f;
    
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hide) withObject:nil afterDelay:2.0];
    }];
}

- (void)hide {
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = .0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
