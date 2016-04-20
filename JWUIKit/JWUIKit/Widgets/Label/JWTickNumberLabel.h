//
//  JWTickNumberLabel.h
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface JWTickNumberLabel : UILabel

@property (assign, nonatomic) IBInspectable CGFloat textValue;//value of the label.Call to change the text with animation.
@property (assign, nonatomic) NSTimeInterval duration;// default is 0.5f.

@property (copy, nonatomic, nullable) IBInspectable NSString *prefixString;
@property (copy, nonatomic, nullable) IBInspectable NSString *suffixString;

- (void)startAnimating;

@end

NS_ASSUME_NONNULL_END
