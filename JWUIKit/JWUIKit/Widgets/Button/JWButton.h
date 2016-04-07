//
//  JWButton.h
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JWButtonImagePosition) {
    JWButtonImagePositionDefault = 0,//image left and text right
    JWButtonImagePositionTop = 1,//image top and text bottom
    JWButtonImagePositionRight = 2//text left and image right
};

IB_DESIGNABLE
@interface JWButton : UIButton

@property (assign, nonatomic) JWButtonImagePosition imagePosition;//default is JWButtonImagePositionDefault. It will change titleEdgeInsets and imageEdgeInsets

@property (assign, nonatomic) IBInspectable CGFloat offset;//default is 0. Must be greater than 0. The margin between text and image. It will change titleEdgeInsets and imageEdgeInsets

@property (assign, nonatomic) IBInspectable CGFloat padding;//default is 0. It will change contentEdgeInsets.

- (void)setImageName:(NSString *)imageName forState:(UIControlState)state;//load image from main bundle

@end

NS_ASSUME_NONNULL_END
