//
//  SGDatabase.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGDatabase.h"
#import "FMDatabaseQueue.h"

@interface SGDatabseHelper : NSObject

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

+ (instancetype)sharedInstance;

@end

@implementation SGDatabseHelper
+ (instancetype)sharedInstance {
    static SGDatabseHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSFileManager defaultManager] createDirectoryAtPath:LIBRARY_SGCCProjectData_PATH withIntermediateDirectories:YES attributes:nil error:NULL];
        NSString *fullPath = [LIBRARY_SGCCProjectData_PATH stringByAppendingPathComponent:DATABASE_NAME];
        self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:fullPath];
    }
    return self;
}
@end


#pragma mark - SGDatabase

@implementation SGDatabase

+ (instancetype) defaultService
{
    static SGDatabase *_defaultService = nil;
    static dispatch_once_t _onceToken;
    dispatch_once (&_onceToken, ^ () {
        _defaultService = [[self alloc] init];
    });
    return _defaultService;
}


- (FMDatabaseQueue *)databaseQueue {
    return [SGDatabseHelper sharedInstance].databaseQueue;
}

- (BOOL)insertItem:(NSObject *)item
{
    return NO;
}

- (void)insertArray:(NSMutableArray *)array
{
    
}

- (BOOL)deleteItem:(NSObject *)item
{
    return NO;
    
}

- (BOOL)deleteAllItems
{
    return NO;
}


- (BOOL)updateItem:(NSObject *)item
{
    return NO;
}


- (NSArray *)selectAllItems
{
    return [[NSMutableArray alloc] init];
}

//判断是否存在
- (BOOL)isExistItem:(NSObject *)item
{
    return NO;
}

@end
