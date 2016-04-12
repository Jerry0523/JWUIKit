//
//  JWRefreshContentViewProtocol.h
//  JWUIKit
//
//  Created by Jerry on 16/4/11.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JWRefreshContentViewProtocol <NSObject>

+ (CGFloat)preferredHeight;

@optional
- (void)setProgress:(CGFloat)progress;

- (void)startLoading;

- (void)stopLoading;

- (void)loadedSuccess;


@end
