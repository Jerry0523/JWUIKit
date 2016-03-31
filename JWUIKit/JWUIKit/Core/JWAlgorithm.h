//
//  JWAlgorithm.h
//  JWUIKit
//
//  Created by Jerry on 16/3/28.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import Foundation;
 
int JWRandom(int from, int to);

float JWConvertValue(float input, float sourceReference, float destinationRefrence);

bool JWVerifyValue(float input, float min, float max);

float JWValueConformTo(float input, float min, float max);

double JWRadians(float degrees);

int* JWCircleIndex(int rowCount, int columnCount);