//
//  JWToast.h
//  JWUIKit
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger, JWToastLength) {
    JWToastLengthShort,
    JWToastLengthLong
};

@interface JWToast : UIView

+ (instancetype)makeToast:(NSString*)msg;

- (void)show;
- (void)showInView:(UIView*)view length:(JWToastLength)length;

- (void)hide;

@end
