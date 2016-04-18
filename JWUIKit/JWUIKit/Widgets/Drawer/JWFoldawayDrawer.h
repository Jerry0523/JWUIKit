//
//  JWFoldawayDrawer.h
//  JWUIKit
//
//  Created by 王杰 on 16/4/15.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

@protocol JWFoldawayDrawerDataSource, JWFoldawayDrawerDelegate;

@interface JWFoldawayDrawer : UIView

@property (assign, nonatomic, readonly) BOOL isOpen;
@property (assign, nonatomic) NSTimeInterval duration;
@property (assign, nonatomic) BOOL autoLayoutSuperView;

@property (weak, nonatomic) id<JWFoldawayDrawerDataSource> dataSource;
@property (weak, nonatomic) id<JWFoldawayDrawerDelegate> delegate;

- (void)open;
- (void)close;

- (void)toggle;

@end

@protocol JWFoldawayDrawerDataSource <NSObject>

@required
- (NSUInteger)numberOfViews;
- (UIView*)viewAtIndex:(NSUInteger)index;
@optional
- (CGFloat)heightOfViewAtIndex:(NSUInteger)index;

@end

@protocol JWFoldawayDrawerDelegate <NSObject>

@optional

- (void)drawer:(JWFoldawayDrawer*)drawer willOpenIndex:(NSUInteger)index;
- (void)drawer:(JWFoldawayDrawer*)drawer didOpenIndex:(NSUInteger)index;

- (void)drawer:(JWFoldawayDrawer*)drawer willCloseIndex:(NSUInteger)index;
- (void)drawer:(JWFoldawayDrawer*)drawer didCloseIndex:(NSUInteger)index;

@end
