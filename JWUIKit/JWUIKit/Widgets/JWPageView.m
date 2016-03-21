//
//  JWPageView.m
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWPageView.h"
//Core
#import "JWUIKitMacro.h"
#import "UIView+JWFrame.h"

@interface JWPageView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowlayout;

@end

@implementation JWPageView

static NSString *cellIdentifier = @"cellIdentifier";

JWUIKitInitialze {
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    self.vertical = NO;
}

#pragma mark - Public
- (void)reloadData {
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [self collectionView:self.collectionView numberOfItemsInSection:0];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.dataSource respondsToSelector:@selector(numberOfPagesInPageView:)]) {
        return [self.dataSource numberOfPagesInPageView:self];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UIView *reuseView = [cell.contentView.subviews firstObject];
    [reuseView removeFromSuperview];
    
    if ([self.dataSource respondsToSelector:@selector(pageView:viewAt:reusableView:)]) {
        reuseView = [self.dataSource pageView:self viewAt:indexPath.row reusableView:reuseView];
    }
    
    reuseView.frame = cell.contentView.bounds;
    reuseView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [cell.contentView addSubview:reuseView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(pageView:didSelectedPageAtIndex:)]) {
        [self.delegate pageView:self didSelectedPageAtIndex:indexPath.row];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    if (scrollView.w == 0 || scrollView.h == 0) {
        return;
    }
    
    NSUInteger idx = 0;
    if (self.vertical) {
        idx = contentOffset.y / scrollView.h;
    } else {
        idx = contentOffset.x / scrollView.w;
    }
    
    self.pageControl.currentPage = idx;
    
    if ([self.delegate respondsToSelector:@selector(pageView:didScrollToIndex:)]) {
        [self.delegate pageView:self didScrollToIndex:idx];
    }
}

#pragma mark - Setter & Getter
- (void)setAutoPlay:(BOOL)autoPlay {
    _autoPlay = autoPlay;
}

- (void)setVertical:(BOOL)vertical {
    _vertical = vertical;
    self.flowlayout.scrollDirection = vertical ? UICollectionViewScrollDirectionVertical : UICollectionViewScrollDirectionHorizontal;
}

- (void)setDataSource:(id<JWPageViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}

- (UICollectionViewFlowLayout*)flowlayout {
    if (!_flowlayout) {
        _flowlayout = [[UICollectionViewFlowLayout alloc] init];
        _flowlayout.minimumLineSpacing = 0;
        _flowlayout.minimumInteritemSpacing = 0;
    }
    return _flowlayout;
}

- (UICollectionView*)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowlayout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    }
    return _collectionView;
}

- (UIPageControl*)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.h - 30, self.w, 30)];
        _pageControl.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _pageControl;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.flowlayout.itemSize = CGSizeMake(self.w, self.h);
}

@end
