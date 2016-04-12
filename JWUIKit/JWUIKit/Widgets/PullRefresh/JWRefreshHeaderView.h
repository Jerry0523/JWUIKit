//
//  JWRefreshHeaderView.h
//  JWUIKit
//
//  Created by Jerry on 16/4/8.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWRefreshContentViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JWPullRefreshState) {
    JWPullRefreshStateIdle,
    JWPullRefreshStateRefreshing
};

typedef NS_ENUM(NSInteger, JWPullRefreshStyle) {
    JWPullRefreshStyleStill,
    JWPullRefreshStyleFollow
};

typedef void (^JWRefreshingBlock)();

@interface JWRefreshHeaderView : UIView

@property (assign, nonatomic) JWPullRefreshStyle style;
@property (strong, nonatomic, nullable) NSString *contentViewClass;

@property (assign, nonatomic, readonly) JWPullRefreshState state;
@property (strong, nonatomic, readonly) UIView<JWRefreshContentViewProtocol> *contentView;

@property (copy, nonatomic, nullable) JWRefreshingBlock refreshingBlock;

+ (instancetype)headerWithRefreshingBlock:(JWRefreshingBlock)refreshingBlock;

- (void)startRefreshing;

- (void)endRefreshing;
- (void)endRefreshingWithDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
