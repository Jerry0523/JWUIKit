//
//  JWSoundLikeLoadingView.h
//  JWUIKit
//
//  Created by 王杰 on 16/3/27.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWSoundLikeLoadingView : UIView

@property (assign, nonatomic) CGFloat barsCount;
@property (strong, nonatomic, nullable) UIColor *tintColor;

@property (assign, nonatomic) CGFloat barsMarginPercent;
@property (assign, nonatomic, readonly) BOOL isAnimating;
@property (assign, nonatomic) NSTimeInterval duration;

- (void)startAnimating;
- (void)stopAnimating;

@end
