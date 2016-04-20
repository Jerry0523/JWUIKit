//
//  JWAnimatedLabel.h
//  JWUIKit
//
//  Created by Jerry on 16/4/19.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface JWAnimatedLabel : UIView

@property (assign, nonatomic) IBInspectable CGFloat lineWidth;

@property (strong, nonatomic) IBInspectable NSString *fontName;
@property (assign, nonatomic) IBInspectable CGFloat fontSize;

@property (assign, nonatomic) IBInspectable BOOL repeat;

@property (strong, nonatomic) IBInspectable NSString *text;

@property (strong, nonatomic) UIFont *font;

@property (assign, nonatomic) UIEdgeInsets contentInset;

@property (assign, nonatomic) NSTimeInterval duration;

- (void)startAnimating;

@end

NS_ASSUME_NONNULL_END
