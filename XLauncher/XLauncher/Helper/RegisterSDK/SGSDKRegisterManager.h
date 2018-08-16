//
//  SGSDKRegisterManager.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGSDKRegisterManager : NSObject
/**
 *  注册第三方sdk信息
 */
+ (void)registerAllSdkInfoWithLaunchOptions:(NSDictionary *)launchOptions;
@end
