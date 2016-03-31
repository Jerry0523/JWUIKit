//
//  JWCircleLoadingView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWLoadingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JWCircleLoadingView : UIView<JWLoadingProtocol>

@property (assign, nonatomic, readonly) BOOL isAnimating;
@property (assign, nonatomic) BOOL cumulative;//default is YES

@end

NS_ASSUME_NONNULL_END
