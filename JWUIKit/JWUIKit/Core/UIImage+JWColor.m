//
//  UIImage+JWColor.m
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "UIImage+JWColor.h"

@implementation UIImage (JWColor)

+ (UIImage*)imageWithColor:(UIColor*)color {
    return [self imageWithColor:color size:CGSizeMake(100, 100)];
}

+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIColor*)mainColor {
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGContextRef context = NULL;
    CGSize thumbSize = self.size;
    if (thumbSize.width > 50 || thumbSize.height > 50) {
        thumbSize = CGSizeMake(50, 50);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        context = CGBitmapContextCreate(NULL,
                                        thumbSize.width,
                                        thumbSize.height,
                                        8,//bits per component
                                        thumbSize.width * 4,
                                        colorSpace,
                                        bitmapInfo);
        
        CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
        CGImageRef cgRef;
#if __IPHONE_OS_VERSION_MIN_REQUIRED
        cgRef = self.CGImage;
#else
        cgRef = [self CGImageForProposedRect:NULL
                                     context:nil
                                       hints:nil];
#endif
        CGContextDrawImage(context, drawRect, cgRef);
        CGColorSpaceRelease(colorSpace);
    }
    
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) {
        CGContextRelease(context);
        return nil;
    }
    
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
    
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height; y++) {
            int offset = 4 * (x * y);
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha =  data[offset + 3];
            NSArray *clr=@[@(red), @(green), @(blue), @(alpha)];
            [cls addObject:clr];
        }
    }
    
    CGContextRelease(context);
    
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor = nil;
    NSUInteger MaxCount = 0;
    
    while ( (curColor = [enumerator nextObject]) != nil ) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) {
            continue;
        }
        MaxCount = tmpCount;
        MaxColor = curColor;
    }
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue] * .7 / 255.0f)];
}

@end
