//
//  JWTextPageControl.h
//  JWUIKit
//
//  Created by Jerry on 16/4/26.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JWTextPageControlSelectionStyle) {
    JWTextPageControlSelectionStylePlain,
    JWTextPageControlSelectionStyleZoom,
    JWTextPageControlSelectionStyleLine,
    JWTextPageControlSelectionStyleRoundRect
};

@interface JWTextPageControl : UIControl

@property (assign, nonatomic) CGFloat textMargin;
@property (strong, nonatomic) NSArray<NSString*> *contents;

@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;

@property (assign, nonatomic) NSInteger selectedIdx;
@property (assign, nonatomic) JWTextPageControlSelectionStyle selectionStyle;

@property (assign, nonatomic) NSTimeInterval duration;

@end
