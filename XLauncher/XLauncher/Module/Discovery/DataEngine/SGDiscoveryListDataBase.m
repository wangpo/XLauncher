//
//  SGDiscoveryListDataBase.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGDiscoveryListDataBase.h"
#import "SGDiscoveryModel.h"

@implementation SGDiscoveryListDataBase

+ (instancetype) defaultService
{
    static SGDiscoveryListDataBase *_defaultService = nil;
    static dispatch_once_t _onceToken;
    dispatch_once (&_onceToken, ^ () {
        _defaultService = [[self alloc] init];
    });
    return _defaultService;
}


- (id)init
{
    if (self = [super init]) {
        [self.databaseQueue inDatabase:^(FMDatabase *db) {
            if ([db open]) {
                NSString *sql =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (identifier TEXT(1024),title TEXT(1024),image TEXT(1024),url TEXT(1024),key TEXT(1024))",KDiscoveryListTable];
                [db executeUpdate:sql];
            }
        }];
    }
    return self;
}

- (BOOL)insertItem:(NSObject *)item
{
    SGDiscoveryModel *model = (SGDiscoveryModel *)item;
    if ([self isExistItem:model]) {
        return YES;//存在就跳过
    }
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(identifier,title,image,url,key) VALUES (?,?,?,?,?)",KDiscoveryListTable];
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql,model.identifier,model.title,model.image,model.url,model.key];
    }];
    return result;
}

-(void)insertArray:(NSMutableArray *)array
{
    for (SGDiscoveryModel *model in array) {
        [self insertItem:model];
    }
}

- (BOOL)deleteItem:(NSObject *)item
{
    SGDiscoveryModel *model = (SGDiscoveryModel *)item;
    if (![self isExistItem:model]) {
        return YES;//不存在就跳过
    }
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM %@ WHERE identifier=?",KDiscoveryListTable];
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql,model.identifier];
    }];
    return result;
}

- (BOOL)deleteAllItems
{
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql=[NSString stringWithFormat:@"DELETE FROM %@",KDiscoveryListTable];
        result = [db executeUpdate:sql];
    }];
    return result;
}

- (BOOL)updateItem:(NSObject *)item
{
    SGDiscoveryModel *model = (SGDiscoveryModel *)item;
    if (![self isExistItem:model]) {
        return NO;//不存在就跳过
    }
   
    NSString *sql=[NSString stringWithFormat:@"UPDATE %@ SET title = ? WHERE identifier = ?",KDiscoveryListTable];
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql,model.title,model.identifier];
    }];
    return result;
}

- (NSMutableArray *)selectAllItems
{
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:0];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@",KDiscoveryListTable];
        FMResultSet *rs=[db executeQuery:sql];
        while ([rs next]) {
            SGDiscoveryModel *model =[[SGDiscoveryModel alloc] init];
            model.identifier =[rs stringForColumn:@"identifier"];
            model.title =[rs stringForColumn:@"title"];
            model.image =[rs stringForColumn:@"image"];
            model.url = [rs stringForColumn:@"url"];
            model.key = [rs stringForColumn:@"key"];
            [array addObject:model];
        }
        [rs close];
    }];
    return array;
}


//判断是否存在
- (BOOL)isExistItem:(NSObject *)item
{
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        SGDiscoveryModel *model = (SGDiscoveryModel *)item;
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@ WHERE identifier=?",KDiscoveryListTable];
        FMResultSet*rs=[db executeQuery:sql,model.identifier];
        while ([rs next]) {
            result = YES;
            [rs close];
            return ;
        }
        result = NO;
        [rs close];
    }];
    return result;
}

@end

