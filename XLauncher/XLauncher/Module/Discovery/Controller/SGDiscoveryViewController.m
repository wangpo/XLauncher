//
//  SGDiscoveryViewController.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGDiscoveryViewController.h"
#import "SGNetworkService+Discovery.h"
#import "SGDiscoveryListEnvelop.h"
#import "SGDiscoveryListCell.h"
#import "SGDiscoveryListDataBase.h"

@interface SGDiscoveryViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation SGDiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - override
- (void)setupViews
{
    [self.navigationBar setNavTitle:@"发现"];
    self.tableView.estimatedRowHeight = 280;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SGNavBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    //注册cell
    [self.tableView registerClass:[SGDiscoveryListCell class] forCellReuseIdentifier:NSStringFromClass([SGDiscoveryListCell class])];
}

- (void)loadCacheData
{
    //读取缓存数据库
    self.dataSource = [[SGDiscoveryListDataBase defaultService] selectAllItems];
}

#pragma mark - Data Request
//首次加载、下拉刷新
- (void)loadNewData
{
    if ([self.dataSource count] == 0) {
         [self showLoadingHUDView:@"加载中..."];
    }
    [[SGNetworkService defaultService] getDiscoveryList:@"" successCallback:^(id data) {
        SGDiscoveryListEnvelop *envelop = data;
        BOOL isEmpty = [envelop.contents count] > 0 ? NO : YES;
        [self setTableStatusWithType:ELoadTypeRefresh isDataEmpty:isEmpty];
        self.dataSource = [envelop.contents mutableCopy];
        [[SGDiscoveryListDataBase defaultService] insertArray:self.dataSource];
        [self.tableView reloadData];
    } failureCallback:^(NSError *error) {
        [self handleErrorCode:SGNetLinkError errorMsg:@"网络连接错误"];
    }];
}

//加载更多
- (void)loadMoreData
{
    SGDiscoveryModel *model = self.dataSource.lastObject;
    [[SGNetworkService defaultService] getDiscoveryList:model.key successCallback:^(id data) {
        SGDiscoveryListEnvelop *envelop = data;
        BOOL isEmpty = [envelop.contents count] > 0 ? NO : YES;
        [self setTableStatusWithType:ELoadTypeLoadMore isDataEmpty:isEmpty];
        [self.dataSource addObjectsFromArray:envelop.contents];
        [self.tableView reloadData];
    } failureCallback:^(NSError *error) {
        [self handleErrorCode:SGNetLinkError errorMsg:@"网络连接错误"];
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

//因为用了自动算高，tableView.rowHeight = UITableViewAutomaticDimension;次代理回调可以不实现，实现的目的是为了缓存高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([SGDiscoveryListCell class]) cacheByIndexPath:indexPath configuration:^(SGDiscoveryListCell * cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGDiscoveryListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SGDiscoveryListCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self configureCell:(SGDiscoveryListCell *)cell atIndexPath:indexPath];
}

- (void)configureCell:(SGDiscoveryListCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.model =  [self.dataSource objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
