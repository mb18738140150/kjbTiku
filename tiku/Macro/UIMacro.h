//
//  UIMacro.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define kNavigationBarHeight 44
#define kTabBarHeight 49
#define kStatusBarHeight 20
#define kCommunityImageWidth ([UIScreen mainScreen].bounds.size.width - 38) / 3
#define kMainSpace 16

#define UIRGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kCommonMainColor UIRGBColor(20.0,120.0,210.0)
#define kCommonNavigationBarColor UIRGBColor(255.0,255.0,255.0)
#define kCommonNavigationBarTextColor UIRGBColor(0,0,0)


#define kTableViewCellSeparatorColor UIRGBColor(220,220,220)
#define kBackgroundGrayColor UIRGBColor(240,240,240)
#define kBackgroundLightGrayColor UIRGBColor(250,250,250)
#define kMainTextColor UIRGBColor(50,50,50)
#define kMainTextColor_100 UIRGBColor(100,100,100)
#define kMainTextColor_150 UIRGBColor(150,150,150)
#define kMainTextColor_200 UIRGBColor(200,200,200)
#define kMainFont [UIFont systemFontOfSize:14]
#define kUILABEL_LINE_SPACE 5

#endif /* UIMacro_h */
