//
//  JWAlgorithm.m
//  JWUIKit
//
//  Created by Jerry on 16/3/28.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWAlgorithm.h"

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