//
//  JWButton.m
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWButton.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@implementation JWButton

JWUIKitInitialze {
    
}

- (void)sizeToFit {
    CGRect frame = self.frame;
    CGSize intrinsicContentSize = [self intrinsicContentSize];
    frame.size = intrinsicContentSize;
    self.frame = frame;
}

- (CGSize)intrinsicContentSize {
    if (self.imagePosition == JWButtonImagePositionTop) {
        CGFloat width = MAX(self.imageView.w, self.titleLabel.intrinsicContentSize.width) + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
        CGFloat height = self.imageView.h + self.titleLabel.intrinsicContentSize.height + self.offset + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
        return CGSizeMake(width, height);
    }
    
    CGSize mSize = [super intrinsicContentSize];
    if (self.offset) {
        mSize.width += self.offset;
    }
    return mSize;
}

#pragma mark - Getter & Setter
- (void)setImagePosition:(JWButtonImagePosition)imagePosition {
    if (_imagePosition != imagePosition) {
        _imagePosition = imagePosition;
        [self updateInsets];
    }
}

- (void)setOffset:(CGFloat)offset {
    if (_offset != offset && offset > 0) {
        _offset = offset;
        [self updateInsets];
    }
}

- (void)setPadding:(CGFloat)padding {
    if (_padding != padding) {
        _padding = padding;
        [self updateInsets];
    }
}

#pragma mark - Private
- (void)updateInsets {
    CGFloat halfOffset = self.offset * .5f;
    if (self.imagePosition == JWButtonImagePositionDefault) {
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, halfOffset, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -halfOffset, 0, 0);
        
    } else if (self.imagePosition == JWButtonImagePositionRight) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.w - self.w + self.titleLabel.intrinsicContentSize.width + halfOffset, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.titleLabel.w - self.w + self.imageView.w + halfOffset);
    } else if(self.imagePosition == JWButtonImagePositionTop) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.w, -self.imageView.h - halfOffset, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height - halfOffset, 0, 0, -self.titleLabel.intrinsicContentSize.width);
    }
    self.contentEdgeInsets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
}


@end
