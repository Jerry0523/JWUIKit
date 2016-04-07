//
//  JWTextField.h
//  JWUIKit
//
//  Created by Jerry on 16/3/18.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JWTextFieldSegmentStyle) {
    JWTextFieldSegmentStylePlain,
    JWTextFieldSegmentStyleCellPhone,
    JWTextFieldSegmentStyleCreditCard
};

IB_DESIGNABLE
@interface JWTextField : UITextField

@property (strong, nonatomic, nullable) NSArray<__kindof UIView*> *leftViews;
@property (strong, nonatomic, nullable) NSArray<__kindof UIView*> *rightViews;

@property (strong, nonatomic, nullable) UIImageView *imageView;//an easy way to set left imageview. It will change leftViews.

@property (assign, nonatomic) IBInspectable CGFloat paddingLeft;//an easy way to add left padding. It will insert a space view into leftViews.

@property (strong, nonatomic, nullable) NSSet<NSNumber*> *segmentValues;//a NSSet contains index of the segment logic.
@property (assign, nonatomic) JWTextFieldSegmentStyle segmentStyle;//a pre-set control to add space by the given format. It will change the segmentValues and keyboardType.

@property (assign, nonatomic) NSUInteger maxTextLength;//default is NSIntegerMax.When set, it will limit the length of trimed text.

- (NSString*)getRawText;//return text without segment space

@end

@interface JWTextFieldSpaceView : UIView

@property (assign, nonatomic) CGFloat space;//default is 10px;

@end

NS_ASSUME_NONNULL_END
