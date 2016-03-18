//
//  JWTickNumberLabel.m
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWTickNumberLabel.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+Frame.h"

@interface JWTickNumberLabel()

@property (assign, nonatomic) BOOL animating;
@property (assign, nonatomic) CGFloat currentValue;
@property (assign, nonatomic) CGFloat stepValue;

@end

@implementation JWTickNumberLabel

JWUIKitInitialze {
    self.stepValue = 0;
    self.duration = 0.5f;
}

#pragma mark - Public
- (void)reloadData {
    if (self.animating) {
        return;
    }
    self.stepValue = self.textValue / (60 * self.duration);
    self.currentValue = 0;
    self.animating = YES;
    __weak typeof(self) weakSelf = self;
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(increaseCurrentValue:)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - Setter & Getter
- (void)setPrefixString:(NSString *)prefixString {
    _prefixString = prefixString;
    self.text = [self stringForValue:self.textValue];
}

- (void)setSuffixString:(NSString *)suffixString {
    _suffixString = suffixString;
    self.text = [self stringForValue:self.textValue];
}

- (void)setTextValue:(CGFloat)textValue {
    _textValue = textValue;
    self.text = [self stringForValue:self.textValue];
    [self reloadData];
}

- (void)setDuration:(NSTimeInterval)duration {
    if (duration > 0) {
        _duration = duration;
    }
}

- (NSString*)stringForValue:(CGFloat)value {
    return [NSString stringWithFormat:@"%@%.2f%@", self.prefixString ? self.prefixString : @"", value, self.suffixString ? self.suffixString : @""];
}

- (void)increaseCurrentValue:(id)sender {
    self.currentValue += self.stepValue;
    if (self.currentValue >= self.textValue) {
        self.currentValue = self.textValue;
        [sender invalidate];
        self.animating = NO;
    }
    self.text = [self stringForValue:self.currentValue];
}

@end
