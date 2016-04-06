//
//  JWToast.h
//  JWUIKit
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

@interface JWToast : UIView

+ (instancetype)makeToast:(NSString*)msg;

- (void)show;
- (void)showInView:(UIView*)view;

- (void)hide;

@end
