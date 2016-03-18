//
//  JWTextField.h
//  JWUIKit
//
//  Created by Jerry on 16/3/18.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JWTextFieldSegmentStyle) {
    JWTextFieldSegmentStylePlain,
    JWTextFieldSegmentStyleCellPhone,
    JWTextFieldSegmentStyleCreditCard
};

@interface JWTextField : UITextField

@property (strong, nonatomic, nullable) NSArray<__kindof UIView*> *leftViews;
@property (strong, nonatomic, nullable) NSArray<__kindof UIView*> *rightViews;

@property (assign, nonatomic) CGFloat paddingHorizontal;

@property (assign, nonatomic) JWTextFieldSegmentStyle segmentStyle;

@property (strong, nonatomic, nullable) NSSet<NSNumber*> *segmentValues;
@property (assign, nonatomic) NSUInteger maxTextLength;//default is NSIntegerMax

- (NSString*)getRawText;

@end

@interface JWTextFieldSpaceView : UIView

@property (assign, nonatomic) CGFloat space;//default is 10px;

@end

NS_ASSUME_NONNULL_END
