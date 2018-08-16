//
//  SGBaseViewController.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGNavigationBar.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "SGNetworkErrorView.h"

@interface SGBaseViewController : UIViewController

@property (nonatomic, strong) SGNavigationBar           *navigationBar;
@property (nonatomic, strong) MBProgressHUD             *toastView;
@property (nonatomic, strong) MBProgressHUD             *loadingView;


/**
 加载中...  显示隐藏

 @param title 
 */
- (void)showLoadingHUDView:(NSString *)title;
- (void)hideLoadingHUDView;

/**
 toast提示

 @param title
 */
- (void)showToastHUDView:(NSString *)title;

/**
  Alert弹框

 @param title 标题
 @param msg 消息
 @param leftTitle 左按钮
 @param leftBlock
 @param rightTitle 右按钮
 @param rightBlock 
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg leftTitle:(NSString *)leftTitle leftBlock:(void(^)(void))leftBlock rightTitle:(NSString *)rightTitle rightBlock:(void(^)(void))rightBlock;

/**
 ActonSheet

 @param items 条目数组
 @param callBackBlock 回调，根据标题区分
 */
- (void)showActionSheet:(NSArray *)items callBackBlock:(void(^)(NSString *item))callBackBlock;
/**
 *  强制竖屏
 */
- (void)forceDeviceOrientationPortrait;

/**
 *  强制横屏
 */
- (void)forceDeviceOrientationLandscape;

@end
