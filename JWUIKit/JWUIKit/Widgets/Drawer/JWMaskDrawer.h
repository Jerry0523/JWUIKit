//
//  JWDrawer.h
//  JWUIKit
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JWMaskDrawerDirection){
    JWMaskDrawerDirectionBottom     = 0,
    JWMaskDrawerDirectionRight      = 1,
    JWMaskDrawerDirectionTop        = 2,
    JWMaskDrawerDirectionLeft       = 3
};

@interface JWMaskDrawer : UIView

@property (strong, nonatomic, nullable) __kindof UIView *contentView;

@property (assign, nonatomic) BOOL modal;
@property (assign, nonatomic) BOOL drawShadow;

@property (assign, nonatomic) JWMaskDrawerDirection direction;
@property (assign, nonatomic) NSTimeInterval duration;

- (void)showInView:(UIView*)superView;

- (void)showInView:(UIView*)superView
        onWindow:(BOOL)upToWindow
        completion:(void (^ __nullable)(__kindof  UIView * _Nullable contentView))completion;

- (void)dismissOnCompletion:(void (^ __nullable)(__kindof UIView * _Nullable contentView))completion;


@end

NS_ASSUME_NONNULL_END

