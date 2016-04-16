//
//  JWDrawer.m
//  JWUIKit
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWMaskDrawer.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWMaskDrawer {
    UIView *_containerView;
    UITapGestureRecognizer *_tapGesture;
}

JWUIKitInitialze {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _containerView = [UIView new];
    [self addSubview:_containerView];
    
    self.direction = JWMaskDrawerDirectionBottom;
    self.drawShadow = YES;
    self.duration = .5f;
    self.modal = YES;
}

- (void)layoutSubviews {
    [self layoutContainerView];
}

-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id hitView = [super hitTest:point withEvent:event];
    if (self.modal) {
        return hitView;
    } else {
        if (hitView == self) {
            return nil;
        } else {
            return hitView;
        }
    }
}

#pragma mark - Public
- (void)showInView:(UIView *)superView {
    [self showInView:superView onWindow:YES completion:nil];
}

- (void)showInView:(UIView *)superView
        onWindow:(BOOL)upToWindow
        completion:(void (^)(__kindof UIView *))completion {
    UIView *parentView = superView;
    if (upToWindow) {
        parentView = parentView.window;
    }
    self.frame = parentView.bounds;
    [parentView addSubview:self];
    
    
    [self beforeShowAnimation];
    
    [UIView animateWithDuration:self.duration animations:^{
        [self afterShowAnimation];
        
    } completion:^(BOOL finished) {
        if (completion) {
            completion(self.contentView);
        }
    }];
    
}

- (void)dismissOnCompletion:(void (^)(__kindof UIView *))completion {
    
    [UIView animateWithDuration:self.duration animations:^{
        [self beforeShowAnimation];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (completion) {
            completion(self.contentView);
        }
    }];
}

#pragma mark - Setter & Getter
- (void)setDirection:(JWMaskDrawerDirection)direction {
    _direction = direction;
    if (self.contentView) {
        [self setNeedsLayout];
    }
}

- (void)setContentView:(__kindof UIView *)contentView {
    _contentView = contentView;
    [_containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (contentView) {
        if (CGRectIsEmpty(contentView.bounds)) {
            [contentView sizeToFit];
        }
        [_containerView addSubview:contentView];
    }
}

- (void)setModal:(BOOL)modal {
    if (_modal != modal) {
        _modal = modal;
        if (modal) {
            _tapGesture = [UITapGestureRecognizer new];
            [_tapGesture addTarget:self action:@selector(tapGestureRecognized:)];
            [self addGestureRecognizer:_tapGesture];
        } else {
            if (_tapGesture) {
                [self removeGestureRecognizer:_tapGesture];
                _tapGesture = nil;
            }
        }
    }
}

#pragma mark - Private
- (void)beforeShowAnimation {
    self.backgroundColor = [UIColor clearColor];
    switch (self.direction) {
        case JWMaskDrawerDirectionBottom:
            [_containerView makeTranslateForX:0 y:_contentView.h];
            break;
        case JWMaskDrawerDirectionRight:
            [_containerView makeTranslateForX:_contentView.w y:0];
            break;
        case JWMaskDrawerDirectionTop:
            [_containerView makeTranslateForX:0 y:-_contentView.h];
            break;
        case JWMaskDrawerDirectionLeft:
            [_containerView makeTranslateForX:-_contentView.w y:0];
            break;
    }
}

- (void)afterShowAnimation {
    if (self.drawShadow) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    }
    switch (self.direction) {
        case JWMaskDrawerDirectionBottom:
            [_containerView makeTranslateForX:0 y:-_contentView.h];
            break;
        case JWMaskDrawerDirectionRight:
            [_containerView makeTranslateForX:-_contentView.w y:0];
            break;
        case JWMaskDrawerDirectionTop:
            [_containerView makeTranslateForX:0 y:_contentView.h];
            break;
        case JWMaskDrawerDirectionLeft:
            [_containerView makeTranslateForX:_contentView.w y:0];
            break;
    }
}

- (void)layoutContainerView {
    switch (self.direction) {
        case JWMaskDrawerDirectionBottom:
            _containerView.frame = CGRectMake(0, self.h - _contentView.h, self.w, _contentView.h);
            _containerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
            break;
        case JWMaskDrawerDirectionRight:
            _containerView.frame = CGRectMake(self.w - _contentView.w, 0, _contentView.w, self.h);
            _containerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
            break;
        case JWMaskDrawerDirectionTop:
            _containerView.frame = CGRectMake(0, 0, self.w, _contentView.h);
            _containerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
            break;
        case JWMaskDrawerDirectionLeft:
            _containerView.frame = CGRectMake(0, 0, _contentView.w, self.h);
            _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
            break;
    }
    _contentView.frame = _containerView.bounds;
}

- (void)tapGestureRecognized:(id)sender {
    [self dismissOnCompletion:nil];
}

@end
