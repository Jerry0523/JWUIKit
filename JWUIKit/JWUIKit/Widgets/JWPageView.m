//
//  JWPageView.m
//  JWUIKit
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWPageView.h"
//Core
#import "UIView+Frame.h"

@interface JWPageView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionViewFlowLayout *flowlayout;

@end

@implementation JWPageView

static NSString *cellIdentifier = @"cellIdentifier";

#pragma mark - Public
- (void)reloadData {
    [self.collectionView reloadData];
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

- (void)layoutSubviews {
    self.flowlayout.itemSize = CGSizeMake(self.w, self.h);
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

- (UICollectionViewFlowLayout*)flowlayout {
    if (!_flowlayout) {
        _flowlayout = [[UICollectionViewFlowLayout alloc] init];
        _flowlayout.minimumLineSpacing = 0;
        _flowlayout.minimumInteritemSpacing = 0;
    }
    return _flowlayout;
}

#pragma mark - Private
- (void)setup {
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowlayout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_collectionView];
    
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    self.vertical = NO;
}

@end
