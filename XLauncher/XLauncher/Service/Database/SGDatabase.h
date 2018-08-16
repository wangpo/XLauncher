//
//  SGDatabase.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

//数据库文件名
#define DATABASE_NAME @"SGCC.sqlite"

@interface SGDatabase : NSObject

@property (nonatomic, readonly) FMDatabaseQueue *databaseQueue;

+ (instancetype)defaultService;
/**
 *  插入单个对象
 *
 *  @param item 数据对象
 *
 *  @return 操作结果
 */
- (BOOL)insertItem:(NSObject *)item;

/**
 *  插入数组
 *
 *  @param array
 */
- (void)insertArray:(NSMutableArray *)array;

/**
 *  删除对象
 *
 *  @param item 数据对象
 *
 *  @return 操作结果
 */
- (BOOL)deleteItem:(NSObject *)item;

/**
 *  清空数据表
 *
 *  @return 操作结果
 */
- (BOOL)deleteAllItems;

/**
 *  更新条目
 *
 *  @param item  
 *
 *  @return 数据对象
 */
- (BOOL)updateItem:(NSObject *)item;

/**
 *  检索
 *
 *  @return 检索结果
 */
- (NSMutableArray *)selectAllItems;

/**
 *  数据表是否存在
 *
 *  @param item 数据对象
 *
 *  @return 操作结果
 */
- (BOOL)isExistItem:(NSObject *)item;

@end
