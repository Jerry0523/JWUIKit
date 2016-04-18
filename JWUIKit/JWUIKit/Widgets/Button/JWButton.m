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
#import "UIImage+JWColor.h"

@implementation JWButton

JWUIKitInitialze {
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
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

- (void)setImageName:(NSString *)imageName forState:(UIControlState)state {
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImage:image forState:state];
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
    self.contentEdgeInsets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
    
    CGSize size = [self intrinsicContentSize];
    CGFloat halfOffset = self.offset * .5f;
    if (self.imagePosition == JWButtonImagePositionDefault) {
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, halfOffset, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -halfOffset, 0, 0);
        
    } else if (self.imagePosition == JWButtonImagePositionRight) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.w - size.width + self.titleLabel.intrinsicContentSize.width + halfOffset + self.padding * 2, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.titleLabel.intrinsicContentSize.width - size.width + self.imageView.w + halfOffset + self.padding * 2);
    } else if(self.imagePosition == JWButtonImagePositionTop) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.w, -self.imageView.h - halfOffset, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height - halfOffset, 0, 0, -self.titleLabel.intrinsicContentSize.width);
    }
}


@end
