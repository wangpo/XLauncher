//
//  SGBaseViewController.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGBaseViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"//右滑返回
#import "UIViewController+DismissKeyboard.h"

@implementation SGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_prefersNavigationBarHidden = YES;//隐藏导航条
    self.edgesForExtendedLayout = UIRectEdgeNone;//不延伸到bar下面
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupForDismissKeyboard];
}

#pragma mark - Setter & Getter
- (SGNavigationBar *)navigationBar
{
    SG_PROPERTY_LOCK(_navigationBar);
    _navigationBar = [SGNavigationBar navigationBarWithTarget:self];
    [self.view addSubview:_navigationBar];
    SG_PROPERTY_UNLOCK();
    return _navigationBar;
}

- (MBProgressHUD *)toastView
{
    SG_PROPERTY_LOCK(_toastView);
    _toastView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _toastView.mode = MBProgressHUDModeText;
    _toastView.removeFromSuperViewOnHide = YES;
    _toastView.label.textColor = [UIColor whiteColor];
    _toastView.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    _toastView.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
    _toastView.bezelView.layer.cornerRadius = 0;
    _toastView.userInteractionEnabled = NO;
    [_toastView hideAnimated:YES afterDelay:1.5];
    SG_PROPERTY_UNLOCK();
    return _toastView;
}

- (MBProgressHUD *)loadingView
{
    SG_PROPERTY_LOCK(_loadingView);
    _loadingView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _loadingView.mode = MBProgressHUDModeCustomView;
    _loadingView.removeFromSuperViewOnHide = YES;
    _loadingView.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    _loadingView.bezelView.color = [UIColor clearColor];
    _loadingView.label.textColor =[UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1];
    _loadingView.label.font = [UIFont systemFontOfSize:15];
    
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    _loadingView.customView = indicator;
    SG_PROPERTY_UNLOCK();
    return _loadingView;
}

- (void)showToastHUDView:(NSString *)title
{
    if (_toastView) {
        [_toastView hideAnimated:NO];
        _toastView = nil;
    }
    [self.toastView.label setText:title];
}

- (void)showLoadingHUDView:(NSString *)title
{
    if (_loadingView){
        [_loadingView hideAnimated:NO];
        _loadingView = nil;
    }
    
    if (title) {
        self.loadingView.label.text = title;
    }
    [self.loadingView showAnimated:YES];
}

- (void)hideLoadingHUDView
{
    if (_loadingView){
        [_loadingView hideAnimated:NO];
        _loadingView = nil;
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg leftTitle:(NSString *)leftTitle leftBlock:(void(^)(void))leftBlock rightTitle:(NSString *)rightTitle rightBlock:(void(^)(void))rightBlock
{
    UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * leftAction = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (leftBlock) {
            leftBlock();
        }
    }];
    UIAlertAction * rightAction = nil;
    if (rightTitle){
        rightAction = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightBlock) {
                rightBlock();
            }
        }];
    }
    [alertCtr addAction:leftAction];
    if (rightAction) {
        [alertCtr addAction:rightAction];
    }
    [self presentViewController:alertCtr animated:YES completion:nil];
}

- (void)showActionSheet:(NSArray *)items callBackBlock:(void(^)(NSString *item))callBackBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    for (NSString *item in items) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:item style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (callBackBlock) {
                callBackBlock(item);
            }
        }];
        [alertController addAction:action];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forceDeviceOrientationPortrait
{
    [self forceDeviceOrientation:UIDeviceOrientationPortrait];
}

- (void)forceDeviceOrientationLandscape
{
    UIInterfaceOrientation statusBarOrientation  = [[UIApplication sharedApplication] statusBarOrientation];
    if (statusBarOrientation == UIDeviceOrientationLandscapeRight) {
        [self forceDeviceOrientation:UIDeviceOrientationLandscapeRight];
    }else{
        [self forceDeviceOrientation:UIDeviceOrientationLandscapeLeft];
    }
}

- (void)forceDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        NSInteger val = deviceOrientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
}

#pragma mark - 个性化定制statusBar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//父视图默认不支持旋转，只支持竖屏方向，子视图根据需要重写
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
