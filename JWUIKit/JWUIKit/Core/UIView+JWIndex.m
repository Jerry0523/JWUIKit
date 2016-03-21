//
//  UIView+JWIndex.m
//  JWUIKit
//
//  Created by Jerry on 16/3/21.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "UIView+JWIndex.h"

@implementation UIView (JWIndex)

- (NSArray<NSNumber*>*)defaultIndex{
    NSMutableArray *indexArray = @[].mutableCopy;
    for (int i = 0; i < self.subviews.count; i++) {
        [indexArray addObject:@(i)];
    }
    return indexArray;
}

- (NSArray<NSNumber*>*)circleIndexForRowCount:(NSUInteger)rc
                                  columnCount:(NSUInteger)cc{
    NSUInteger totalCount = rc * cc;
    NSMutableArray *indexArray = @[].mutableCopy;
    
    NSUInteger direction = 0;
    
    NSInteger rowIdx = 0;
    NSInteger columnIdx = 0;
    
    for (int i = 0; i < totalCount; i++) {
        NSUInteger value = rowIdx * cc + columnIdx;
        [indexArray addObject:@(value)];
        
        if (direction == 0) {
            columnIdx++;
            if (columnIdx >= cc || [self arrayContainsColumnIndex:columnIdx
                                                         rowIndex:rowIdx
                                                      columnCount:cc array:indexArray]) {
                direction = 1;
                rowIdx++;
                columnIdx -= 1;
            }
        } else if(direction == 1) {
            rowIdx++;
            if (rowIdx >= rc || [self arrayContainsColumnIndex:columnIdx
                                                      rowIndex:rowIdx
                                                   columnCount:cc array:indexArray]) {
                direction = 2;
                columnIdx--;
                rowIdx -= 1;
            }
        } else if(direction == 2) {
            columnIdx--;
            if (columnIdx < 0 || [self arrayContainsColumnIndex:columnIdx
                                                       rowIndex:rowIdx
                                                    columnCount:cc array:indexArray]) {
                direction = 3;
                rowIdx--;
                columnIdx += 1;
            }
        } else if(direction == 3) {
            rowIdx--;
            if (rowIdx < 0 || [self arrayContainsColumnIndex:columnIdx
                                                 rowIndex:rowIdx
                                              columnCount:cc array:indexArray]) {
                direction = 0;
                columnIdx++;
                rowIdx += 1;
            }
        }
    }
    return indexArray;
}

#pragma mark - Private
- (BOOL)arrayContainsColumnIndex:(NSUInteger)columnIdx
                        rowIndex:(NSUInteger)rowIdx
                     columnCount:(NSUInteger)columnCount
                           array:(NSArray<NSNumber*>*)array {
    
    NSUInteger value = rowIdx * columnCount + columnIdx;
    return [array containsObject:@(value)];
}

@end
