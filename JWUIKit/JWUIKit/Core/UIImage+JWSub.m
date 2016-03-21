//
//  UIImage+JWSub.m
//  JWUIKit
//
//  Created by Jerry on 16/3/21.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "UIImage+JWSub.h"

@implementation UIImage (JWSub)

-(UIImage*)getSubImage:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)), subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

-(UIImage*)scaleToSize:(CGSize)size {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height / height;
    float horizontalRadio = size.width / width;
    
    float radio = MIN(verticalRadio, horizontalRadio);
    
    width *= radio;
    height *= radio;
    
    int xPos = (size.width - width) / 2;
    int yPos = (size.height-height) / 2;
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
