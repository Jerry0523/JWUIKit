//
//  JWArrow.h
//  JWUIKit
//
//  Created by 王杰 on 16/4/9.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JWArrowDirection) {
    JWArrowDirectionTop         = 0,
    JWArrowDirectionLeft,
    JWArrowDirectionBottom,
    JWArrowDirectionRight
    
};

IB_DESIGNABLE
@interface JWArrow : UIView

@property (assign, nonatomic) JWArrowDirection direction;
@property (assign, nonatomic) IBInspectable CGFloat lineWidth;

@end

NS_ASSUME_NONNULL_END
