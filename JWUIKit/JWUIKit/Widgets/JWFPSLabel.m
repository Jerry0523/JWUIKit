//
//  OTSFPSLabel.m
//  OneStore
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWFPSLabel.h"
#import <CoreFoundation/CoreFoundation.h>

#define kSize CGSizeMake(55, 20)

@implementation JWFPSLabel {
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
}

#pragma mark - LifeCycle
- (instancetype)init {
    if (self = [super init]) {
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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return kSize;
}

- (void)dealloc {
    [_link invalidate];
}

#pragma mark - Private
- (void)setup {
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    self.font = [UIFont fontWithName:@"Menlo" size:14];
    
    __weak typeof(self) weakSelf = self;
    _link = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / (2 * delta);
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%dfps",(int)round(fps)]];
   [text setAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:color}
                 range:NSMakeRange(0, text.length - 3)];
    [text setAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:[UIColor whiteColor]}
                  range:NSMakeRange(text.length - 3, 3)];
    
    self.attributedText = text;
}

@end
