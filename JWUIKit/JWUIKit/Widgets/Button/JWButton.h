//
//  JWButton.h
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN;

typedef NS_ENUM(NSInteger, JWButtonImagePosition) {
    JWButtonImagePositionDefault = 0,//image left and text right
    JWButtonImagePositionTop = 1,//image top and text bottom
    JWButtonImagePositionRight = 2//text left and image right
};

@interface JWButton : UIButton

@property (assign, nonatomic) JWButtonImagePosition imagePosition;//default is JWButtonImagePositionDefault. It will change the titleEdgeInsets and imageEdgeInsets

@property (assign, nonatomic) CGFloat offset;//default is 0. Must be greater than 0. The gap margin between text and image. It will change the titleEdgeInsets and imageEdgeInsets

@property (assign, nonatomic) CGFloat padding;//default is 0. It will change the contentEdgeInsets.

@end

NS_ASSUME_NONNULL_END;
