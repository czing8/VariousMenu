//
//  UIColor+Extends.h
//
//
//  Created by Vols on 16/3/11.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define kRGB(r, g, b)       [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
//#define kRGBA(r,g,b,a)      [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]

#define kRGBHex(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

typedef struct
{
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
}RGBA;


@interface UIColor (VAdd)

+ (nullable UIColor *)randomColor;

+ (nullable UIColor *)colorWithHex:(int)hexValue;
+ (nullable UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (nullable UIColor *)colorWithHexString:(nullable NSString *)hexStr;

/**
 *  获取UIColor对象的RGBA值
 *
 *  @param color UIColor
 *
 *  @return RGBA
 */
RGBA RGBAFromUIColor(UIColor * _Nonnull color);

@end



@interface UIColor (FlatColors)

+ (nullable UIColor *)flatRedColor;
+ (nullable UIColor *)flatDarkRedColor;

+ (nullable UIColor *)flatGreenColor;
+ (nullable UIColor *)flatDarkGreenColor;

+ (nullable UIColor *)flatBlueColor;
+ (nullable UIColor *)flatDarkBlueColor;

+ (nullable UIColor *)flatTealColor;
+ (nullable UIColor *)flatDarkTealColor;

+ (nullable UIColor *)flatPurpleColor;
+ (nullable UIColor *)flatDarkPurpleColor;

+ (nullable UIColor *)flatBlackColor;
+ (nullable UIColor *)flatDarkBlackColor;

+ (nullable UIColor *)flatYellowColor;
+ (nullable UIColor *)flatDarkYellowColor;

+ (nullable UIColor *)flatOrangeColor;
+ (nullable UIColor *)flatDarkOrangeColor;

+ (nullable UIColor *)flatWhiteColor;
+ (nullable UIColor *)flatDarkWhiteColor;

+ (nullable UIColor *)flatGrayColor;
+ (nullable UIColor *)flatDarkGrayColor;

@end
