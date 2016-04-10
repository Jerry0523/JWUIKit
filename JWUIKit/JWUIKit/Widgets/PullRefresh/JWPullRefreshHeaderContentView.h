//
//  JWPullRefreshHeaderContentView.h
//  JWUIKit
//
//  Created by 王杰 on 16/4/9.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWProgressProtocol.h"

@interface JWPullRefreshHeaderContentView : UIView<JWProgressProtocol>

- (void)beginLoading;
- (void)stopLoading;

@end
