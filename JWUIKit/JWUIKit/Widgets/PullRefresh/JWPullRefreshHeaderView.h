//
//  JWPullRefreshHeaderView.h
//  JWUIKit
//
//  Created by Jerry on 16/4/8.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;
#import "JWPullRefreshHeaderContentView.h"


typedef NS_ENUM(NSInteger, JWPullRefreshState) {
    JWPullRefreshStateDefault,
    JWPullRefreshStateRefreshing
};

@interface JWPullRefreshHeaderView : UIView

@property (assign, nonatomic) JWPullRefreshState state;
@property (strong, nonatomic) JWPullRefreshHeaderContentView *contentView;

@end
