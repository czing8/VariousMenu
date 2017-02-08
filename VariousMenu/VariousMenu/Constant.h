//
//  Constant.h
//  VariousMenu
//
//  Created by Vols on 2017/2/7.
//  Copyright © 2017年 vols. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#ifdef DEBUG
#define VLog(...) NSLog(__VA_ARGS__)
#else
#define VLog(...)
#endif



#define kSCREEN_SIZE  [UIScreen mainScreen].bounds.size

#define kRGB(r, g, b)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kRGBHex(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]




// 背景色
#define kAppBakgroundColor          kRGBHex(0xEFEFF4)

// 导航主色调
#define kNavBarThemeColor           kRGBHex(0xDC4B53)


#endif /* Constant_h */
