//
//  JWLoadingViewProtocol.h
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import Foundation;

@protocol JWLoadingProtocol <NSObject>

- (void)startAnimating;

- (void)stopAnimating;

- (BOOL)isAnimating;

@end
