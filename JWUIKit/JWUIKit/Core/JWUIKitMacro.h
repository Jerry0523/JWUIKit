//
//  JWUIKitMacro.h
//  JWUIKit
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#ifndef JWUIKitMacro_h
#define JWUIKitMacro_h

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

#endif /* JWUIKitMacro_h */
