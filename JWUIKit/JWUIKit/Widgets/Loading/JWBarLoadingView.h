//
//  JWBarLoadingView.h
//  JWUIKit
//
//  Created by 王杰 on 16/3/27.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWBaseLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JWBarLoadingStyle){
    JWBarLoadingStyleSound   = 0,
    JWBarLoadingStyleWave     = 1
};

@interface JWBarLoadingView : JWBaseLoadingView

@property (assign, nonatomic) CGFloat barsCount;
@property (assign, nonatomic) CGFloat barsMarginPercent;

@property (assign, nonatomic) JWBarLoadingStyle style;
@property (assign, nonatomic) NSTimeInterval duration;

@end

NS_ASSUME_NONNULL_END
