//
//  SGBaseTableViewController.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGBaseViewController.h"
#import "UIScrollView+Placeholder.h"
#import "NSError+SGCC.h"
#import "UITableView+FDTemplateLayoutCell.h"

typedef NS_ENUM(NSInteger, ELoadType)
{
    ELoadTypeRefresh,//首次加载，下拉刷新
    ELoadTypeLoadMore,//上拉加载更多
};

@interface SGBaseTableViewController : SGBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableViewStyle _tableViewStyle;//tableView风格，默认plain,如需修改，重写init方法
}

@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) MJRefreshNormalHeader     *mjRefreshHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *mjRefreshFooter;
@property (nonatomic, strong) SGNetworkErrorView        *networkErrorView;


#pragma mark - 子类重写
/**
 构建页面
 */
- (void)setupViews;
/**
 加载数据缓存
 */
- (void)loadCacheData;

/**
 首次加载、下拉刷新
 */
- (void)loadNewData;

/**
 加载更多
 */
- (void)loadMoreData;

/**
 网络请求成功回调处理

 @param type 加载类型
 @param isEmpty 返回数据是否为空
 */
- (void)setTableStatusWithType:(ELoadType)type isDataEmpty:(BOOL)isEmpty;

/**
 网络请求失败回调处理

 @param code 错误状态码
 @param msg 错误描述
 */
- (void)handleErrorCode:(SGStatusCode)code errorMsg:(NSString *)msg;

@end
