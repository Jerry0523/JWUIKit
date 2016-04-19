//
//  JWUIKitMacro.h
//  JWUIKit
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#ifndef JWUIKitMacro_h
#define JWUIKitMacro_h

//Initialize
#define JWUIKitInitialze \
\
- (instancetype)init {\
if (self = [super init]) {\
    [self setup];\
}\
return self;\
}\
\
- (instancetype)initWithCoder:(NSCoder *)aDecoder {\
    if (self = [super initWithCoder:aDecoder]) {\
        [self setup];\
    }\
    return self;\
}\
\
- (instancetype)initWithFrame:(CGRect)frame {\
    if (self = [super initWithFrame:frame]) {\
        [self setup];\
    }\
    return self;\
}\
\
- (void)setup \

//Colors
#define JWColor(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

#define JWHexColor(hexValue) JWColor((float)((hexValue & 0xFF0000) >> 16), \
                                     (float)((hexValue & 0xFF00) >> 8), \
                                     (float)(hexValue & 0xFF), 1.0f)

#define JWRandomColor() [UIColor colorWithHue:(arc4random() % 256 / 256.0) \
                                   saturation:(arc4random() % 128 / 256.0) + 0.5 \
                                   brightness:(arc4random() % 128 / 256.0) + 0.5 \
                                        alpha:1]

#endif /* JWUIKitMacro_h */
