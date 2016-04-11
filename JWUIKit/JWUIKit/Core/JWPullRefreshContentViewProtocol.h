//
//  JWPullRefreshContentViewProtocol.h
//  JWUIKit
//
//  Created by Jerry on 16/4/11.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JWPullRefreshContentViewProtocol <NSObject>

@optional
- (void)setProgress:(CGFloat)progress;

- (void)startLoading;

- (void)stopLoading;

- (void)loadedSuccess;


@end
