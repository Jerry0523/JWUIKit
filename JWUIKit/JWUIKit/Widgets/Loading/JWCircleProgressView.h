//
//  JWCircleProgressView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/22.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JWCircleProgressStyle){
    JWCircleProgressStyleDefault,
    JWCircleProgressStylePie
};

@interface JWCircleProgressView : UIView

@property (assign, nonatomic) CGFloat progress;
@property (assign, nonatomic) JWCircleProgressStyle style;

@property (strong, nonatomic, null_resettable) UIColor *color;//default is white

@end
