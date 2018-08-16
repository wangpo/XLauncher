//
//  SGBaseTableViewController.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGBaseTableViewController.h"

@implementation SGBaseTableViewController

//如果子类需要修改tableview样式则需重写init修改样式。
- (instancetype)init
{
    self = [super init];
    if (self) {
        _tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self setupViews];
    [self loadCacheData];
    [self loadNewData];
}

#pragma mark - 子类重写
- (void)setupViews{}
- (void)loadCacheData{}
- (void)loadNewData{}
- (void)loadMoreData{}

#pragma mark - Setter & Getter
- (UITableView *)tableView
{
    SG_PROPERTY_LOCK(_tableView);
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:_tableViewStyle];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    /*
     * 去掉空白 cell 的分割线
     */
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake (0, 0, 0, CGFLOAT_MIN)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectMake (0, 0, 0, CGFLOAT_MIN)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    /*
     * 分割线风格
     */
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorInset = UIEdgeInsetsMake (0, 10, 0, 10);
    _tableView.mj_header = self.mjRefreshHeader;
    _tableView.mj_footer = self.mjRefreshFooter;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    SG_PROPERTY_UNLOCK();
    return _tableView;
}

- (MJRefreshNormalHeader *)mjRefreshHeader {
    SG_PROPERTY_LOCK(_mjRefreshHeader);
    _mjRefreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _mjRefreshHeader.automaticallyChangeAlpha = YES;
    _mjRefreshHeader.lastUpdatedTimeLabel.hidden = YES;
    _mjRefreshHeader.stateLabel.hidden = YES;
    _mjRefreshHeader.stateLabel.textColor = [UIColor darkGrayColor];
    _mjRefreshHeader.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    SG_PROPERTY_UNLOCK();
    return _mjRefreshHeader;
}

- (MJRefreshAutoNormalFooter *)mjRefreshFooter {
    SG_PROPERTY_LOCK(_mjRefreshFooter);
    _mjRefreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_mjRefreshFooter setTitle:@"" forState:MJRefreshStateIdle];
    [_mjRefreshFooter setTitle:@"" forState:MJRefreshStateRefreshing];
    [_mjRefreshFooter setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [_mjRefreshFooter setTitle:@"没有了" forState:MJRefreshStateNoMoreData];
    _mjRefreshFooter.stateLabel.font = [UIFont systemFontOfSize:13];
    _mjRefreshFooter.stateLabel.textColor = [UIColor darkGrayColor];
    SG_PROPERTY_UNLOCK();
    return _mjRefreshFooter;
}

- (SGNetworkErrorView *)networkErrorView
{
    SG_PROPERTY_LOCK(_networkErrorView);
    _networkErrorView = [[SGNetworkErrorView alloc] init];
    @weakify(self);
    _networkErrorView.tapHandler = ^{
        @strongify(self);
        [self hideNetErrorView];
        [self showLoadingHUDView:@"加载中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadNewData];
        });
        
    };
    SG_PROPERTY_UNLOCK();
    return _networkErrorView;
}

#pragma mark - 网络回调处理
- (void)setTableStatusWithType:(ELoadType)type isDataEmpty:(BOOL)isEmpty {
    switch (type) {
        case ELoadTypeRefresh:
        {
            [self hideLoadingHUDView];
            [self.tableView.mj_header endRefreshing];
            if (isEmpty) {
                [self.tableView placeholderImage:[UIImage imageNamed:@""] title:@"暂时没有数据"];
                if (self.tableView.mj_footer) {
                    self.tableView.mj_footer.hidden = YES;
                }
            }else {
                if (self.tableView.didSetup) {
                    [self.tableView removePlaceholder];
                }
                if (self.tableView.mj_footer) {
                    self.tableView.mj_footer.hidden = NO;
                    [self.tableView.mj_footer setState:MJRefreshStateIdle];
                }
            }
        }
            break;
        case ELoadTypeLoadMore:
        {
            if (isEmpty) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [self.tableView.mj_footer endRefreshing];
            }
        }
            break;
    }
}

- (void)handleErrorCode:(SGStatusCode)code errorMsg:(NSString *)msg
{
    [self hideLoadingHUDView];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if ((code == SGNetLinkError) && ([self.tableView numberOfRowsInSection:0] > 0)) {
        [self showToastHUDView:@"数据加载失败"];
    }else{
        switch (code) {
            case SGShowMsg:
            {
                [self showToastHUDView:msg];
            }
                break;
            case SGNetLinkError:
            {
                [self showNetErrorView];
            }
                break;
            default:
                break;
        }
    }
}

- (void)showNetErrorView
{
    if (!_networkErrorView) {
        [self.view addSubview:self.networkErrorView];
        [self.networkErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tableView);
        }];
    }else {
        _networkErrorView.hidden = NO;
    }
}

- (void)hideNetErrorView
{
    if (_networkErrorView) {
        _networkErrorView.hidden = YES;
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
