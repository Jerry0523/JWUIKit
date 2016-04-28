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
@property (strong, nonatomic) JWPageControl *pageControl;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowlayout;

@end

@implementation JWPageView

static NSString *cellIdentifier = @"cellIdentifier";

JWUIKitInitialze {
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    self.cycled = YES;
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - Public
- (void)reloadData {
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [self rawCellCount];
    [self.collectionView reloadData];
    
    if (self.cycled) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    [self resetAutoPlayTimer];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSUInteger count = [self rawCellCount];
    if (self.cycled && count) {
        count += 2;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UIView *reuseView = [cell.contentView.subviews firstObject];
    [reuseView removeFromSuperview];
    
    if ([self.dataSource respondsToSelector:@selector(pageView:viewAt:reusableView:)]) {
        reuseView = [self.dataSource pageView:self viewAt:[self parseRowIndex:indexPath.row] reusableView:reuseView];
    }
    
    reuseView.frame = cell.contentView.bounds;
    reuseView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [cell.contentView addSubview:reuseView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(pageView:didSelectedPageAtIndex:)]) {
        [self.delegate pageView:self didSelectedPageAtIndex:[self parseRowIndex:indexPath.row]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:scrollView.contentOffset];
    NSUInteger idx = indexPath.item;
    self.pageControl.currentPage = [self parseRowIndex:idx];
    
    if ([self.delegate respondsToSelector:@selector(pageView:didScrollToIndex:)]) {
        [self.delegate pageView:self didScrollToIndex:self.pageControl.currentPage];
    }
    
    if (self.cycled) {
        NSUInteger totalCount = [self collectionView:self.collectionView numberOfItemsInSection:0];
        if (indexPath.item == 0) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[self rawCellCount] inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        } else if (indexPath.item + 1 == totalCount) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self resetAutoPlayTimer];
}

#pragma mark - Setter & Getter
- (NSInteger)selectedIdx {
    return self.pageControl.currentPage;
}

- (void)setSelectedIdx:(NSInteger)selectedIdx {
    
    NSInteger idx = selectedIdx;
    if (self.cycled) {
        idx += 1;
    }
    
    NSInteger totalCount = [self collectionView:self.collectionView numberOfItemsInSection:0];
    if (idx < 0 || idx >= totalCount) {
        return;
    }
    
    [self resetAutoPlayTimer];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

- (void)setAutoPlayInterval:(NSTimeInterval)autoPlayInterval {
    if (autoPlayInterval >= 0 && _autoPlayInterval != autoPlayInterval) {
        _autoPlayInterval = autoPlayInterval;
        [self resetAutoPlayTimer];
    }
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
        _flowlayout.sectionInset = UIEdgeInsetsZero;
        _flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
        _pageControl = [[JWPageControl alloc] initWithFrame:CGRectMake(0, self.h - 30, self.w, 30)];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _pageControl;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.flowlayout.itemSize = CGSizeMake(self.w, self.h);
}

#pragma mark - Private
- (NSUInteger)rawCellCount {
    NSUInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfPagesInPageView:)]) {
        count =  [self.dataSource numberOfPagesInPageView:self];
    }
    return count;
}

- (NSUInteger)parseRowIndex:(NSUInteger)input {
    NSUInteger rawCount = [self rawCellCount];
    NSUInteger output = input;
    
    if (input == 0) {
        output = rawCount - 1;
    } else if(input == rawCount + 1) {
        output = 0;
    } else {
        output--;
    }
    return output;
}

- (void)resetAutoPlayTimer {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (_autoPlayInterval) {
        [self performSelector:@selector(triggerNextPage:) withObject:nil afterDelay:_autoPlayInterval inModes:@[NSRunLoopCommonModes]];
    }
}

- (void)triggerNextPage:(id)sender {
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset];
    NSUInteger totalCount = [self collectionView:self.collectionView numberOfItemsInSection:0];
    
    if (totalCount == 0) {
        return ;
    }
    
    NSUInteger currentIdx = indexPath.item;
    if (currentIdx == totalCount - 1) {
        currentIdx = 0;
    } else {
        currentIdx++;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIdx inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
    [self resetAutoPlayTimer];
}

@end
