//
//  JWRollNumberLabel.h
//  JWUIKit
//
//  Created by Jerry on 16/4/12.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface JWRollNumberLabel : UIView

@property (strong, nonatomic) IBInspectable NSString *text;
@property (strong, nonatomic) IBInspectable UIColor *textColor;
@property (assign, nonatomic) IBInspectable CGFloat fontSize;

@property (strong, nonatomic) UIFont *font;

@end
NS_ASSUME_NONNULL_END
