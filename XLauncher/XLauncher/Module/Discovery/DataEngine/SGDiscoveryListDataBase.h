//
//  SGDiscoveryListDataBase.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGDatabase.h"

#define KDiscoveryListTable   @"discoveryList" //发现列表

@interface SGDiscoveryListDataBase : SGDatabase

+ (instancetype)defaultService;

@end
