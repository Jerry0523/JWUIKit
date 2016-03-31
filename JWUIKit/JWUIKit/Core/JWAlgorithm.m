//
//  JWAlgorithm.m
//  JWUIKit
//
//  Created by Jerry on 16/3/28.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWAlgorithm.h"

extern bool JWArrayContains(int* array, int length, int value);
extern bool JWArrayContainsIndex(int* array, int length, int columnIdx, int rowIdx, int columnCount);

int JWRandom(int from, int to) {
    return (int)(from + (arc4random() % (to - from + 1)));
}

float JWConvertValue(float input, float sourceReference, float destinationRefrence) {
    return input * destinationRefrence / sourceReference;
}

bool JWVerifyValue(float input, float min, float max) {
    return input >= min && input <= max;
}

float JWValueConformTo(float input, float min, float max) {
    return MAX(min, MIN(input, max));
}

double JWRadians(float degrees) {
    return (degrees * M_PI) / 180.0;
}

int* JWCircleIndex(int rowCount, int columnCount) {
    int totalCount = rowCount * columnCount;
    int *array = malloc(totalCount * sizeof(int));
    memset(array, -1, totalCount * sizeof(int));
    
    int direction = 0;
    
    int rowIdx = 0;
    int columnIdx = 0;
    
    for (int i = 0; i < totalCount; i++) {
        long value = rowIdx * columnCount + columnIdx;
        if (JWArrayContains(array, totalCount, value)) {
            break;
        } else {
            array[i] = value;
        }
        
        if (direction == 0) {
            columnIdx++;
            if (columnIdx >= columnCount || JWArrayContainsIndex(array, totalCount, columnIdx, rowIdx, columnCount)) {
                direction = 1;
                rowIdx++;
                columnIdx -= 1;
            }
        } else if(direction == 1) {
            rowIdx++;
            if (rowIdx >= columnCount || JWArrayContainsIndex(array, totalCount, columnIdx, rowIdx, columnCount)) {
                direction = 2;
                columnIdx--;
                rowIdx -= 1;
            }
        } else if(direction == 2) {
            columnIdx--;
            if (columnIdx < 0 || JWArrayContainsIndex(array, totalCount, columnIdx, rowIdx, columnCount)) {
                direction = 3;
                rowIdx--;
                columnIdx += 1;
                
            }
        } else if(direction == 3) {
            rowIdx--;
            if (rowIdx < 0 || JWArrayContainsIndex(array, totalCount, columnIdx, rowIdx, columnCount)) {
                direction = 0;
                columnIdx++;
                rowIdx += 1;
            }
        }
    }
    return array;
}

//Private
bool JWArrayContains(int* array, int length, int value) {
    for (int i = 0; i < length; i++) {
        if (array[i] == value) {
            return true;
        }
    }
    return false;
}

bool JWArrayContainsIndex(int* array, int length, int columnIdx, int rowIdx, int columnCount) {
    int value = rowIdx * columnCount + columnIdx;
    return JWArrayContains(array, length, value);
}