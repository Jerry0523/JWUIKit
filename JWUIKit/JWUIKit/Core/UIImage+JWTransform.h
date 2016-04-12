//
//  UIImage+JWTransfrom.h
//  JWUIKit
//
//  Created by Jerry on 16/3/21.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

@interface UIImage (JWTransfrom)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)getScaledImage:(CGSize)size;

@end
