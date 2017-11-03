//
//  JSAlertSheetViewController.h
//  AlertView
//
//  Created by Milton on 17/9/18.
//  Copyright © 2017年 Milton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSAlertAction.h"
#import "JSSheepPresentTransition.h"

@class JSAlertSheetViewController;

@protocol JSAlertSheetViewControllerDelegate <NSObject>

NS_ASSUME_NONNULL_BEGIN
- (void)js_alertSheetViewController:(JSAlertSheetViewController *)alertController selectedIndex:(NSInteger)index;

@end

@interface JSAlertSheetViewController : UIViewController

/**
 初始化方法

 @param transition 模态协议
 @return 控制器 可以在里面处理事件
 */
- (instancetype)initWithTransition:(JSSheepPresentTransition *)transition;

/**
 添加Action

 @param action JSAlertAction
 */

- (void)addAction:(JSAlertAction *)action;


/**
 代理
 */
@property (nonatomic, weak)id<JSAlertSheetViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
