//
//  JWBaseLoadingView.h
//  JWUIKit
//
//  Created by Jerry on 16/4/5.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWLoadingProtocol.h"

@interface JWBaseLoadingView : UIView<JWLoadingProtocol>

@property (assign, nonatomic) BOOL isAnimating;

- (void)setup;

@end
