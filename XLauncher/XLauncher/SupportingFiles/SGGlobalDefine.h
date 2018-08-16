//
//  SGGlobalDefine.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#ifndef SGGlobalDefine_h
#define SGGlobalDefine_h

#pragma mark - 设备尺寸
//设备全屏宽度
#define SGFullScreenWidth     ([UIScreen mainScreen].bounds.size.width  < [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)
//设备全屏高度
#define SGFullScreenHeight     ([UIScreen mainScreen].bounds.size.width  < [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)

//以iPhone6位标准尺寸，根据高度适配宽度
#define WH(f) (SGFullScreenHeight/667*(f))
//以iPhone6位标准尺寸，根据宽度适配高度
#define HI(f) (SGFullScreenWidth/375*(f))

#pragma mark - 颜色转换
//十进制颜色转换
#define RGBCOLOR(r,g,b)         [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//十六进制颜色转换（0xFFFFFF）
#define HEXRGBCOLOR(hex)        [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
#define HEXRGBACOLOR(hex,a)     [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]

#pragma mark - 字体宏
#define SGFontSize(size)       ([UIFont systemFontOfSize:size])

#pragma mark - 适配
#define SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]

#define  IOS8_Later      ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define  IOS9_Later      ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define  IOS10_Later      ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define  IOS11_Later      ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

#define isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//Retina 4
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//Retina HD 4.7
#define isIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//Retina HD 5.5
#define isIPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define LIBRARY_PATH             [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES) objectAtIndex:0]
#define LIBRARY_SGCCProjectData_PATH      [LIBRARY_PATH stringByAppendingPathComponent:@"SGCCProjectData"]

#define SGStatusBarHeight         (isIPhoneX ? 44 : 20)
#define SGNavBarHeight            (isIPhoneX ? 88 : 64)
#define SGTabBarHeight            (isIPhoneX ? 83 : 49)
#define SGSafeAreaBottomHeight    (isIPhoneX ? 34 :  0)

#endif /* SGGlobalDefine_h */
