//
//  UIImage+JWTransfrom.m
//  JWUIKit
//
//  Created by Jerry on 16/3/21.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "UIImage+JWTransform.h"

@implementation UIImage (JWTransfrom)

-(UIImage*)getSubImage:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *subImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return subImage;
}

-(UIImage*)getScaledImage:(CGSize)size {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height / height;
    float horizontalRadio = size.width / width;
    
    float radio = MIN(verticalRadio, horizontalRadio);
    
    width *= radio;
    height *= radio;
    
    int xPos = (size.width - width) / 2;
    int yPos = (size.height - height) / 2;
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
