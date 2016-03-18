//
//  JWTextField.m
//  JWUIKit
//
//  Created by Jerry on 16/3/18.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWTextField.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+Frame.h"

@implementation JWTextField

JWUIKitInitialze {
    [self addTarget:self action:@selector(dealWithSegment:) forControlEvents:UIControlEventEditingChanged];
    self.maxTextLength = NSIntegerMax;
}

#pragma mark - Setter & Getter
- (void)setLeftViews:(NSArray<__kindof UIView *> *)leftViews {
    _leftViews = leftViews;
    UIView *containerView = nil;
    if ([leftViews count] > 0) {
        containerView = [self createContainerViewForItems:leftViews];
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    self.leftView = containerView;
}

- (void)setRightViews:(NSArray<__kindof UIView *> *)rightViews {
    _rightViews = rightViews;
    UIView *containerView = nil;
    if ([rightViews count] > 0) {
        containerView = [self createContainerViewForItems:rightViews];
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    self.rightView = containerView;
}

- (void)setPaddingHorizontal:(CGFloat)paddingHorizontal {
    JWTextFieldSpaceView *leftSpaceView = [JWTextFieldSpaceView new];
    leftSpaceView.space = paddingHorizontal;
    
    NSArray *mLeftViews;
    if (self.leftViews) {
        NSMutableArray *mutable = [NSMutableArray arrayWithArray:self.leftViews];
        [mutable insertObject:leftSpaceView atIndex:0];
        mLeftViews = mutable;
    } else {
        mLeftViews = @[leftSpaceView];
    }
    self.leftViews = mLeftViews;
    
    JWTextFieldSpaceView *rightSpaceView = [JWTextFieldSpaceView new];
    rightSpaceView.space = paddingHorizontal;
    NSArray *mRightViews;
    if (self.rightViews) {
        NSMutableArray *mutable = [NSMutableArray arrayWithArray:self.rightViews];
        [mutable insertObject:rightSpaceView atIndex:mutable.count];
        mRightViews = mutable;
    } else {
        mRightViews = @[rightSpaceView];
    }
    self.rightViews = mRightViews;
}

- (void)setSegmentStyle:(JWTextFieldSegmentStyle)segmentStyle {
    _segmentStyle = segmentStyle;
    NSSet *set;
    switch (segmentStyle) {
        case JWTextFieldSegmentStyleCellPhone: {
            NSMutableSet *mutableSet = [NSMutableSet set];
            [mutableSet addObject:@(3)];
            [mutableSet addObject:@(7)];
            set = mutableSet;
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.maxTextLength = 11;
        }
            break;
        case JWTextFieldSegmentStyleCreditCard: {
            NSMutableSet *mutableSet = [NSMutableSet set];
            [mutableSet addObject:@(4)];
            [mutableSet addObject:@(8)];
            [mutableSet addObject:@(12)];
            set = mutableSet;
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.maxTextLength = 16;
        }
            break;
        default:
            set = nil;
            break;
    }
    self.segmentValues = set;
}

- (void)setSegmentValues:(NSSet<NSNumber *> *)segmentValues {
    _segmentValues = segmentValues;
}

- (NSString*)getRawText {
    return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark - Private
- (UIView*)createContainerViewForItems:(NSArray<__kindof UIView *> *)items {
    UIView *containerView = [UIView new];
    CGFloat containerHeight = 0;
    for (int i = 0; i < items.count; i++) {
        UIView *leftView = items[i];
        if (CGRectIsEmpty(leftView.bounds)) {
            [leftView sizeToFit];
        }
        containerHeight = MAX(leftView.h, containerHeight);
        [leftView moveToPoint:CGPointMake(containerView.subviews.lastObject.maxX, 0)];
        [containerView addSubview:leftView];
        if (i == items.count - 1) {
            containerView.w = leftView.maxX;
            containerView.h = containerHeight;
        }
    }
    return containerView;
}

- (void)dealWithSegment:(id)sender {
    if (!self.segmentValues) {
        return;
    }
    NSString *trimText = [self getRawText];
    if ([self shouldStopWithTrimString:trimText]) {
        return;
    }
    
    if ([self.segmentValues containsObject:@(trimText.length)]) {
        self.text = [NSString stringWithFormat:@"%@ ", self.text];
    }
}

- (void)deleteBackward {
    NSString *modifiedString = self.text;
    
    if (modifiedString.length < 2 ) {
        [super deleteBackward];
        return;
    }
    
    NSString *lastString = [modifiedString substringFromIndex:modifiedString.length - 1];
    if ([lastString isEqualToString:@" "] && modifiedString.length >= 2) {
        lastString = [modifiedString substringToIndex:modifiedString.length - 2];
        self.text = lastString;
    } else {
        [super deleteBackward];
    }
}

- (BOOL)shouldStopWithTrimString:(NSString*)trimString {
    if (trimString.length > self.maxTextLength) {
        self.text = [self.text substringToIndex:self.text.length - 1];
        return YES;
    }
    return NO;
}

@end

@implementation JWTextFieldSpaceView

JWUIKitInitialze {
    self.space = 10.0;
}

#pragma mark - Setter & Getter
- (void)setSpace:(CGFloat)space {
    _space = space;
    self.w = space;
    self.h = 1.0f;
}

@end
