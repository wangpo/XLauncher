# XLauncher
app启动器，初始化工程
1. 基于（SGBaseTabBarController + SGBaseNavigationController + SGBaseViewController）形式的整体布局。
2. SGBaseTableViewController列表基类支持下拉刷新、上拉加载，无数据/无网络提示。具体参见SGDiscoveryViewController样例
3. 集成网络请求服务SGNetworkService，利用AF+YYKit的组合，支持网络请求自动解析。
4. 支持数据库缓存FMDB。
