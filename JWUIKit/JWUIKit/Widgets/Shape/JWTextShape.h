//
//  JWTextShape.h
//  JWUIKit
//
//  Created by Jerry on 16/4/19.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface JWTextShape : UIView

@property (strong, nonatomic) IBInspectable NSString *text;
@property (assign, nonatomic) IBInspectable CGFloat lineWidth;

@property (strong, nonatomic, nullable) UIFont *font;

@property (assign, nonatomic) UIEdgeInsets contentInset;

@property (assign, nonatomic) NSTimeInterval duration;

- (void)beginSimpleAnimation;

@end

NS_ASSUME_NONNULL_END
