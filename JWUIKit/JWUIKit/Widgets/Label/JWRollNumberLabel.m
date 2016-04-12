//
//  JWRollNumberLabel.m
//  JWUIKit
//
//  Created by Jerry on 16/4/12.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWRollNumberLabel.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWRollNumberLabel

JWUIKitInitialze {
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:16.0];
}

#pragma mark - Setter & Getter
- (void)setText:(NSString *)text {
    if ([_text isEqualToString:text]) {
        _text = text;
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}

#pragma mark - Private
- (void)setupSubViewsByTextChange {
    for (int i = 0; i < self.text.length; i++) {
        NSString *s = [self.text substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"m"]) {
            NSRange range = NSMakeRange(i, 1);
            
        }
    }
}

@end
