//
//  JWTextPageControl.m
//  JWUIKit
//
//  Created by Jerry on 16/4/26.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWTextPageControl.h"

//Core
#import "JWUIKitMacro.h"
#import "JWAlgorithm.h"
#import "UIView+JWFrame.h"

@implementation JWTextPageControl {
    NSArray<UIButton*> *_buttonsArray;
    UIScrollView *_scrollView;
    UIView *_selectionView;
}

JWUIKitInitialze {
    self.duration = 0.5f;
    self.font = [UIFont systemFontOfSize:16.0];
    self.textMargin = 20.0f;
    self.textColor = [UIColor blackColor];
    
    _selectedIdx = -1;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_scrollView];
}

- (void)layoutSubviews {
    if (_buttonsArray.count == 0) {
        return;
    }
    
    CGFloat totalWidth = 0;
    for (int i = 0; i < _buttonsArray.count; i++) {
        UIButton *button = _buttonsArray[i];
        [button sizeToFit];
        button.h = self.h;
        totalWidth += button.w;
    }
    
    if (totalWidth > self.w) {
        CGFloat pointX = 0;
        for (int i = 0; i < _buttonsArray.count; i++) {
            UIButton *button = _buttonsArray[i];
            [button originToPoint:CGPointMake(pointX, 0)];
            pointX = CGRectGetMaxX(button.frame);
        }
        _scrollView.contentSize = CGSizeMake(pointX, 0);
    } else {
        CGFloat itemWidth = self.w / _buttonsArray.count;
        for (int i = 0; i < _buttonsArray.count; i++) {
            UIButton *button = _buttonsArray[i];
            button.w = itemWidth;
            [button originToPoint:CGPointMake(itemWidth * i, 0)];
        }
        _scrollView.contentSize = CGSizeMake(self.w, 0);
    }
}

- (void)tintColorDidChange {
    for (int i = 0; i < _buttonsArray.count; i++) {
        UIButton *button = _buttonsArray[i];
        [button setTitleColor:self.tintColor forState:UIControlStateSelected];
    }
    
    if (self.selectionStyle == JWTextPageControlSelectionStyleLine) {
        _selectionView.backgroundColor = self.tintColor;
    }
}

#pragma mark - Setter & Getter
- (void)setSelectionStyle:(JWTextPageControlSelectionStyle)selectionStyle {
    if (_selectionStyle != selectionStyle) {
        _selectionStyle = selectionStyle;
        
        [_selectionView removeFromSuperview];
        _selectionView = nil;
        
        if (selectionStyle == JWTextPageControlSelectionStyleLine) {
            _selectionView = [[UIView alloc] initWithFrame:CGRectMake(0, self.h - 2.0, 0, 2.0)];
            _selectionView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            _selectionView.backgroundColor = self.tintColor;
            [_scrollView addSubview:_selectionView];
        } else if(selectionStyle == JWTextPageControlSelectionStyleRoundRect) {
            _selectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 6.0, 0, self.h - 12.0f)];
            _selectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            _selectionView.backgroundColor = [UIColor colorWithWhite:.8f alpha:1.0];
            _selectionView.layer.cornerRadius = _selectionView.h * .5f - 2;
            _selectionView.layer.masksToBounds = YES;
            [_scrollView insertSubview:_selectionView atIndex:0];
        }
    }
}

- (void)setSelectedIdx:(NSInteger)selectedIdx {
    if (_selectedIdx != selectedIdx && JWVerifyValue(selectedIdx, 0, _buttonsArray.count - 1)) {
        _selectedIdx = selectedIdx;
        for (int i = 0; i < _buttonsArray.count; i++) {
            UIButton *button = _buttonsArray[i];
            BOOL oldSelected = button.selected;
            button.selected = (i ==selectedIdx);
            BOOL newSelected = button.selected;
            
            if (oldSelected != newSelected) {
                if (self.selectionStyle == JWTextPageControlSelectionStyleZoom) {
                    [UIView animateWithDuration:self.duration animations:^{
                        button.transform = newSelected ? CGAffineTransformMakeScale(1.1, 1.1) : CGAffineTransformIdentity;
                    }];
                }
            }
        }
        
        if(self.selectionStyle == JWTextPageControlSelectionStyleLine || self.selectionStyle == JWTextPageControlSelectionStyleRoundRect) {
            [self layoutIfNeeded];
            UIButton *selectedButton = _buttonsArray[selectedIdx];
            [UIView animateWithDuration:self.duration animations:^{
                _selectionView.x = selectedButton.x + (selectedIdx == 0 ? self.textMargin * .5 : 0);
                _selectionView.w = selectedButton.w - ((self.selectedIdx == 0 || self.selectedIdx == _buttonsArray.count - 1) ? self.textMargin * .5f : 0);
            }];
        }
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        [self fixScrollViewContentOffset];
    }
}

- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
        [self refreshButtonsByFontChange];
        [self setNeedsLayout];
    }
}
- (void)setTextMargin:(CGFloat)textMargin {
    if (_textMargin != textMargin) {
        _textMargin = textMargin;
        [self refreshButtonsInsetsByPaddingChanged];
        [self setNeedsLayout];
    }
}

- (void)setContents:(NSArray<NSString *> *)contents {
    if (_contents != contents) {
        _contents = contents;
        [_buttonsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSMutableArray *buttonsNewArray = @[].mutableCopy;
        
        for (int i = 0; i < contents.count; i++) {
            NSString *title = contents[i];
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:title forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            [buttonsNewArray addObject:button];
            [_scrollView addSubview:button];
        }

        _buttonsArray = buttonsNewArray;
        
        [self refreshButtonsColorByTextColor];
        [self refreshButtonsByFontChange];
        [self refreshButtonsInsetsByPaddingChanged];
        [self setNeedsLayout];
        
        self.selectedIdx = 0;
    }
}

#pragma mark - Private
- (void)buttonDidClicked:(UIButton*)sender {
    for (int i = 0; i < _buttonsArray.count; i++) {
        UIButton *button = _buttonsArray[i];
        if (sender == button) {
            self.selectedIdx = i;
            break;
        }
    }
}

- (void)refreshButtonsByFontChange {
    for (int i = 0; i < _buttonsArray.count; i++) {
        UIButton *button = _buttonsArray[i];
        button.titleLabel.font = self.font;
    }
}

- (void)refreshButtonsColorByTextColor {
    for (int i = 0; i < _buttonsArray.count; i++) {
        UIButton *button = _buttonsArray[i];
        [button setTitleColor:self.textColor forState:UIControlStateNormal];
        [button setTitleColor:self.tintColor forState:UIControlStateSelected];
    }
}

- (void)refreshButtonsInsetsByPaddingChanged {
    for (int i = 0; i < _buttonsArray.count; i++) {
        UIButton *button = _buttonsArray[i];
        CGFloat left = i == 0 ? self.textMargin : self.textMargin * .5f;
        CGFloat right = i == _buttonsArray.count - 1 ? self.textMargin : self.textMargin * .5f;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, left, 0, right);
    }
}

- (void)fixScrollViewContentOffset {
    if (_scrollView.contentSize.width > self.w) {
        UIButton *currentView = _buttonsArray[self.selectedIdx];
        if (currentView.x - _scrollView.contentOffset.x + currentView.w > self.w) {
            UIButton *nextView = (self.selectedIdx == _buttonsArray.count - 1 ? currentView : _buttonsArray[self.selectedIdx + 1]);
            [_scrollView setContentOffset:CGPointMake(nextView.maxX - self.w, 0) animated:YES];
        } else if(currentView.x < _scrollView.contentOffset.x) {
            UIButton *preView = (self.selectedIdx == 0 ? currentView : _buttonsArray[self.selectedIdx - 1]);
            [_scrollView setContentOffset:CGPointMake(preView.x, 0) animated:YES];
        }
    }
}

@end
