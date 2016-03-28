//
//  JWPageView.h
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN;

@protocol JWPageViewDataSource, JWPageViewDelegate;

@interface JWPageView : UIView

@property (strong, nonatomic, readonly) UICollectionView *collectionView;
@property (strong, nonatomic, readonly) UIPageControl *pageControl;

@property (weak, nonatomic, nullable) id<JWPageViewDataSource> dataSource;
@property (weak, nonatomic, nullable) id<JWPageViewDelegate> delegate;

@property (assign, nonatomic) BOOL cycled;
@property (assign, nonatomic) BOOL autoPlay;
@property (assign, nonatomic) BOOL vertical;

- (void)reloadData;

@end

@protocol JWPageViewDataSource <NSObject>

- (NSUInteger)numberOfPagesInPageView:(JWPageView *)aPageView;

- (UIView*)pageView:(JWPageView *)aPageView viewAt:(NSUInteger)aIndex reusableView:(nullable __kindof UIView*)reusableView;

@end

@protocol JWPageViewDelegate <NSObject>

@optional
- (void)pageView:(JWPageView *)aPageView didSelectedPageAtIndex:(NSUInteger)aIndex;

- (void)pageView:(JWPageView *)pageView didScrollToIndex:(NSUInteger)aIndex;

@end

NS_ASSUME_NONNULL_END;