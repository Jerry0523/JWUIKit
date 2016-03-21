//
//  UIView+JWIndex.h
//  JWUIKit
//
//  Created by Jerry on 16/3/21.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JWIndex)

- (NSArray<NSNumber*>*)defaultIndex;

- (NSArray<NSNumber*>*)circleIndexForRowCount:(NSUInteger)rc
                                  columnCount:(NSUInteger)cc;

@end
