//
//  UIView+JWAnimation.h
//  JWUIKit
//
//  Created by Jerry on 16/3/21.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN;

@interface UIView (JWAnimation)

- (void)performSubViewIteratorAnimationWith:(CABasicAnimation*)animation
                                    indexes:(nullable NSArray<NSNumber*>*) indexses
                                   duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END;
