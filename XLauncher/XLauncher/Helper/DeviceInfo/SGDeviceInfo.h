//
//  SGDeviceInfo.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *const Device_Simulator;

extern NSString *const Device_iPod;
extern NSString *const Device_iPad;

extern NSString *const Device_iPhone4x;//iphone4、iphone4s
extern NSString *const Device_iPhone5x;//iphone5、iphone5c
extern NSString *const Device_iPhone5s;//iphone5s
extern NSString *const Device_iPhone6x;//iphone6/6p、
extern NSString *const Device_iPhone6s;//iphone6s/6sp、iphoneSE
extern NSString *const Device_iPhone7x;//iphone7/7p

extern NSString *const Device_Unrecognized;

@interface SGDeviceInfo : NSObject

+(NSString*)machineName;

/**
 * 获取设备类别 e.g. @"iPhone"
 * @return NSString: 设备类别.
 */
+ (NSString *)getDeviceModel;

/**
 * 获取设备的本地化版本 localized version
 * @return NSString: 设备的本地化版本.
 */
+ (NSString *)getDeviceLocalizedModel;

/**
 * 获取设备系统名称 e.g. @"iOS"
 * @return NSString: 设备系统名称.
 */
+ (NSString *)getDeviceSystemName;

/**
 * 获取设备当前系统的版本 e.g. @"7.0"
 * @return NSString:设备当前系统的版本.
 */
+ (NSString *)getDeviceSystemVersion;



/**
 * 获取设备电池当前状态 e.g. @"UIDeviceBatteryStateCharging"
 * @return NSString:设备电池当前状态.
 */
+ (NSString *)getDeviceBatteryState;

/**
 * 获取设备电池电量(百分制), e.g. @"90%"
 * @return NSString:设备电池电量.
 */
+ (NSString *)getDeviceBatteryLevel;

/**
 * 获取设备总存储空间,单位换算按照1024,满整数值无小数点,否则精确到小数点后2位 e.g. @"16GB",@"15.12GB"
 * @return NSString:设备总存储空间.
 */
+ (NSString *)getDeviceTotalDiskSpace;

/**
 * 获取设备剩余存储空间,单位换算按照1024,满整数值无小数点,否则精确到小数点后2位,根据获取值自动匹配数据单位（GB,MB,KB）e.g. @"3.21G",@"900M"
 * @return NSString:设备剩余存储空间.
 */
+ (NSString *)getDeviceFreeDiskSpace;

/**
 * 获取当前设备总内存,单位换算按照1024,满整数值无小数点,否则精确到小数点后2位,根据获取值自动匹配数据单位（GB,MB,KB）e.g.@"1GB",@"512MB"
 * @return NSString:当前设备总内存.
 */
+ (NSString *)getDeviceTotalMemory;

/**
 * 获取当前设备可用内存,单位换算按照1024,满整数值无小数点,否则精确到小数点后2位,根据获取值自动匹配数据单位（GB,MB,KB）e.g.@"1GB",@"512MB"
 * @return NSString:当前设备可用内存.
 */
+ (NSString *)getDeviceFreeMemory;

/**
 * 获取设备Mac地址,ios7禁止获取mac地址
 * @return NSString:设备Mac地址.
 */
+ (NSString *)getDeviceMacAddress;

/**
 * 判断设备是否越狱
 * @return BOOL:YES 已越狱,NO 未越狱.
 */
+ (BOOL)isJailBreak;



/**
 硬件机型

 @return <#return value description#>
 */
+ (NSString *)deviceName;

@end
