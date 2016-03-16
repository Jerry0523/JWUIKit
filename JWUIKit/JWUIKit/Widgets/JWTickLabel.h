//
//  JWTickLabel.h
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWTickLabel : UIView

@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *textColor;

@property (assign, nonatomic) CGFloat textValue;

@property (copy, nonatomic) NSString *prefixString;
@property (copy, nonatomic) NSString *suffixString;

- (void)beginAnimation;

@end
