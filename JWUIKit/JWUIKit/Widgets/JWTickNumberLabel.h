//
//  JWTickNumberLabel.h
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JWTickNumberLabel : UILabel

@property (assign, nonatomic) CGFloat textValue;

@property (copy, nonatomic, nullable) NSString *prefixString;
@property (copy, nonatomic, nullable) NSString *suffixString;

@property (assign, nonatomic) NSTimeInterval duration;// default is 0.5f.

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
