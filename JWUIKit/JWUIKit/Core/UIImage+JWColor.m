//
//  UIImage+JWColor.m
//  JWUIKit
//
//  Created by Jerry on 16/3/29.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "JWUIKitMacro.h"
#import "UIImage+JWColor.h"
#import "UIImage+JWTransform.h"

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
    CGImageRef cgRef = self.CGImage;
    CGSize thumbSize = self.size;
    if (thumbSize.width > 50 || thumbSize.height > 50) {
        thumbSize = CGSizeMake(50, 50);
        UIImage *scaledImage = [self getScaledImage:thumbSize];
        cgRef = scaledImage.CGImage;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                    thumbSize.width,
                                    thumbSize.height,
                                    8,
                                    thumbSize.width * 4,
                                    colorSpace,
                                    kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, thumbSize.width, thumbSize.height), cgRef);
    CGColorSpaceRelease(colorSpace);
    
    

    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) {
        CGContextRelease(context);
        return nil;
    }
    
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
    
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height; y++) {
            int offset = 4 * (thumbSize.width * x + y);
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha =  data[offset + 3];
            NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
            [cls addObject:clr];
        }
    }
    
    CGContextRelease(context);
    
    NSEnumerator *enumerator = [cls objectEnumerator];
    
    NSArray *curColor = nil;
    NSArray *maxColor = nil;
    NSUInteger maxCount = 0;
    
    while ( (curColor = [enumerator nextObject]) != nil ) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < maxCount ) {
            continue;
        }
        maxCount = tmpCount;
        maxColor = curColor;
    }
    
    return JWColor([maxColor[0] intValue], [maxColor[1] intValue], [maxColor[2] intValue], [maxColor[3] intValue] / 255.0f);
}

@end
