//
//  SGDeviceInfo.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGDeviceInfo.h"
#import <sys/mount.h>
#import <Foundation/NSProcessInfo.h>
#import <mach/mach.h>
#import <sys/stat.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <sys/utsname.h>

NSString *const Device_Simulator = @"Simulator";
NSString *const Device_iPod = @"iPod";
NSString *const Device_iPad = @"iPad";

NSString *const Device_iPhone4x = @"iPhone 4x";//4,4s
NSString *const Device_iPhone5x = @"iPhone 5x";//5,5c
NSString *const Device_iPhone5s = @"iPhone 5s";//5s
NSString *const Device_iPhone6x = @"iPhone 6x";//6,6p
NSString *const Device_iPhone6s = @"iPhone 6s";//6s,6sp,se
NSString *const Device_iPhone7x = @"iPhone 7x";//7,7p

NSString *const Device_Unrecognized = @"unrecognized";

@implementation SGDeviceInfo

//iPhone8,1
+(NSString*)machineName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

+ (NSString *)getDeviceModel
{
    UIDevice* device = [UIDevice currentDevice];
    return device.model;
}

+ (NSString *)getDeviceLocalizedModel
{
    UIDevice* device = [UIDevice currentDevice];
    return device.localizedModel;
}

+ (NSString *)getDeviceSystemName
{
    UIDevice* device = [UIDevice currentDevice];
    return device.systemName;
}

+ (NSString *)getDeviceSystemVersion
{
    UIDevice* device = [UIDevice currentDevice];
    return device.systemVersion;
}


+ (NSString *)getDeviceBatteryLevel
{
    UIDevice* device = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"%f%%",device.batteryLevel*100];
}

+ (NSString *)getDeviceBatteryState
{
    UIDevice* device = [UIDevice currentDevice];
    return [self batteryStateToString:device.batteryState];
}

+ (NSString*)batteryStateToString:(UIDeviceBatteryState)state
{
    switch ( state ) {
        case UIDeviceBatteryStateUnplugged:{
            return @"UIDeviceBatteryStateUnplugged";
        }
        case UIDeviceBatteryStateCharging: {
            return @"UIDeviceBatteryStateCharging";
        }
        case UIDeviceBatteryStateFull: {
            return @"UIDeviceBatteryStateFull";
        }
        default:{
            return @"UIDeviceBatteryStateUnknown";
        }
    }
}

+ (NSString *)getDeviceTotalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:@"/private/var" error:nil];
    NSString *totalSpace = fattributes[@"NSFileSystemSize"];
    unsigned long long totalSpaceNum = [totalSpace longLongValue];
    totalSpace = [NSString stringWithFormat:@"%llu",totalSpaceNum];
    
    return [self convertUnitToFit:totalSpace];
}

+ (NSString *)getDeviceFreeDiskSpace
{
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:@"/private/var" error:nil];
    NSString *freeSpace = fattributes[@"NSFileSystemFreeSize"];
    unsigned long long freeSpaceNum = [freeSpace longLongValue];
    freeSpace = [NSString stringWithFormat:@"%llu",freeSpaceNum];
    
    return [self convertUnitToFit:freeSpace];
}

+ (NSString *)getDeviceTotalMemory
{
    unsigned long long deviceMemory_number = [[NSProcessInfo processInfo] physicalMemory];
    NSString *deviceMemory = [NSString stringWithFormat:@"%llu",deviceMemory_number];
    
    return [self convertUnitToFit:deviceMemory];
    
}

+ (NSString *)getDeviceFreeMemory
{
    NSString *freeMemory = @"";
    vm_statistics_data_t vmStats;
    if (memoryInfo(&vmStats)) {
        unsigned long free_count_size  = vmStats.free_count * vm_page_size;
        freeMemory = [self convertUnitToFit:[NSString stringWithFormat:@"%lu",free_count_size]];
    }
    
    return freeMemory;
    
}

+ (NSString *)convertUnitToFit:(NSString *)ByteStringValue
{
    unsigned long long minValue = 1024*1024;
    unsigned long long maxValue = 1024*1024*1024;
    unsigned long long ByteNumber = [ByteStringValue longLongValue];
    
    if (minValue < ByteNumber && ByteNumber< maxValue ) {
        return [self convertUnitToMB:ByteStringValue];
    }
    else if (ByteNumber >= maxValue){
        return [self convertUnitToGB:ByteStringValue];
    }
    
    return [NSString stringWithFormat:@"%@KB",ByteStringValue];
    
}

+ (NSString *)convertUnitToMB:(NSString *)ByteStringValue
{
    NSDecimalNumber *decimalNum = [NSDecimalNumber decimalNumberWithString:ByteStringValue];
    NSDecimal changeDecimal = [[NSNumber numberWithLong:1024*1024] decimalValue];
    decimalNum = [decimalNum decimalNumberByDividingBy:
                  [NSDecimalNumber decimalNumberWithDecimal:changeDecimal]];
    NSString *mbStringValue = [decimalNum stringValue];
    NSRange range = [mbStringValue rangeOfString:@"."];
    if (range.length) {
        mbStringValue =  [NSString stringWithFormat:@"%@",[mbStringValue substringToIndex:range.location+3]];
    }
    
    return [NSString stringWithFormat:@"%@MB",mbStringValue];
    
}

+ (NSString *)convertUnitToGB:(NSString *)ByteStringValue
{
    NSDecimalNumber *decimalNum = [NSDecimalNumber decimalNumberWithString:ByteStringValue];
    NSDecimal changeDecimal = [[NSNumber numberWithLongLong:1024*1024*1024] decimalValue];
    decimalNum = [decimalNum decimalNumberByDividingBy:
                  [NSDecimalNumber decimalNumberWithDecimal:changeDecimal]];
    NSString *gbStringValue = [decimalNum stringValue];
    NSRange range = [gbStringValue rangeOfString:@"."];
    if (range.length) {
        gbStringValue =  [NSString stringWithFormat:@"%@",[gbStringValue substringToIndex:range.location+3]];
        
    }
    
    return [NSString stringWithFormat:@"%@GB",gbStringValue];
}

+ (NSString *)getDeviceMacAddress
{
    if ([[self getDeviceSystemVersion] compare:@"7.0"] == NSOrderedDescending || [[self getDeviceSystemVersion] compare:@"7.0"] == NSOrderedSame) {
        NSLog(@"You can not get the MAC address in iOS7 or later");
        return nil;
    }
    int                   mib[6];
    size_t                len;
    char                  *buf;
    unsigned char         *ptr;
    struct if_msghdr      *ifm;
    struct sockaddr_dl    *sdl;
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}

+ (BOOL)isJailBreak
{
    
    int res = access("/var/mobile/Library/AddressBook/AddressBook.sqlitedb", F_OK);
    if (res != 0){
        return NO;
    }
    
    return YES;
    
}

+ (NSString *)deviceName
{
    NSString* device = [SGDeviceInfo machineName];
    if ([device hasPrefix:@"i386"] || [device hasPrefix:@"x86_64"]){
        
        return Device_Simulator;
        
    }else if ([device hasPrefix:@"iPod"]){
        
        return Device_iPod;
        
    }else if ([device hasPrefix:@"iPad"]){
        
        return Device_iPad;
        
    }else if ([device hasPrefix:@"iPhone3"] || [device hasPrefix:@"iPhone4"]){
        
        return Device_iPhone4x;
        
    }else if ([device hasPrefix:@"iPhone5"]){
        
        return Device_iPhone5x;
        
    }else if ([device hasPrefix:@"iPhone6"]){
        
        return Device_iPhone5s;
        
    }else if ([device hasPrefix:@"iPhone7"]){
        
        return Device_iPhone6x;
        
    }else if ([device hasPrefix:@"iPhone8"]){
        
        return Device_iPhone6s;
        
    }else if ([device hasPrefix:@"iPhone9"]){
        
        return Device_iPhone7x;
        
    }else{
        return Device_Unrecognized;
    }
    
}

BOOL memoryInfo(vm_statistics_data_t *vmStats)
{
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)vmStats, &infoCount);
    
    return kernReturn == KERN_SUCCESS;
}

@end
