//
//  JWTickLabel.m
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWTickLabel.h"
//Core
#import "UIView+Frame.h"

@interface JWTickLabel()

@property (strong, nonatomic) UILabel *textLabel;
@property (assign, nonatomic) BOOL animating;
@property (assign, nonatomic) CGFloat currentValue;
@property (assign, nonatomic) CGFloat stepValue;

@end

@implementation JWTickLabel
#pragma mark - Public
- (void)beginAnimation {
    if (self.animating) {
        return;
    }
    
    self.stepValue = self.textValue / 30.0f;
    self.currentValue = 0;
    self.animating = YES;
    __weak typeof(self) weakSelf = self;
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(increaseCurrentValue:)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - LifeCycle
- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.textLabel sizeThatFits:size];
}

- (void)sizeToFit{
    return [self.textLabel sizeToFit];
}

#pragma mark - Setter & Getter
- (UILabel*)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.frame = self.bounds;
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _textLabel;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.textLabel.font = font;
}

- (void)setPrefixString:(NSString *)prefixString {
    _prefixString = prefixString;
    self.textLabel.text = [self stringForValue:self.textValue];
}

- (void)setSuffixString:(NSString *)suffixString {
    _suffixString = suffixString;
    self.textLabel.text = [self stringForValue:self.textValue];
}

- (void)setTextValue:(CGFloat)textValue {
    _textValue = textValue;
    self.textLabel.text = [self stringForValue:self.textValue];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textLabel.textColor = textColor;
}

#pragma mark - Private
- (void)setup {
    [self addSubview:self.textLabel];
    self.stepValue = 0;
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
    self.textLabel.text = [self stringForValue:self.currentValue];
}

@end
