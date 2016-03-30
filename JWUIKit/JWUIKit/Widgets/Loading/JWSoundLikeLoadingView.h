//
//  JWSoundLikeLoadingView.h
//  JWUIKit
//
//  Created by 王杰 on 16/3/27.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;
#import "JWLoadingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JWSoundLikeLoadingView : UIView<JWLoadingProtocol>

@property (assign, nonatomic) CGFloat barsCount;

@property (assign, nonatomic) CGFloat barsMarginPercent;
@property (assign, nonatomic, readonly) BOOL isAnimating;
@property (assign, nonatomic) NSTimeInterval duration;

@end

NS_ASSUME_NONNULL_END
