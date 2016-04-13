//
//  JWSimpleShape.h
//  JWUIKit
//
//  Created by Jerry on 16/4/12.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface JWSimpleShape : UIView

@property (assign, nonatomic) IBInspectable CGFloat lineWidth;

@property (strong, nonatomic) IBInspectable NSString *type;
@property (strong, nonatomic) IBInspectable NSString *subType;

- (void)beginSimpleAnimation;

@end

CA_EXTERN NSString *const JWSimpleShapeTypeYes;
CA_EXTERN NSString *const JWSimpleShapeTypeArrow;
CA_EXTERN NSString *const JWSimpleShapeTypeHeart;
CA_EXTERN NSString *const JWSimpleShapeTypePentastar;


CA_EXTERN NSString *const JWSimpleShapeSubTypeArrowTop;
CA_EXTERN NSString *const JWSimpleShapeSubTypeArrowBottom;
CA_EXTERN NSString *const JWSimpleShapeSubTypeArrowLeft;
CA_EXTERN NSString *const JWSimpleShapeSubTypeArrowRight;

CA_EXTERN NSString *const JWSimpleShapeSubTypeHeartFilled;

CA_EXTERN NSString *const JWSimpleShapeSubTypePentastarFilled;
CA_EXTERN NSString *const JWSimpleShapeSubTypePentastarFilledHalf;

NS_ASSUME_NONNULL_END
