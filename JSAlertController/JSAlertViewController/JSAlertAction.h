//
//  JSAlertAction.h
//  AlertView
//
//  Created by Milton on 17/9/18.
//  Copyright © 2017年 Milton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSAlertMultiModel.h"

NS_ASSUME_NONNULL_BEGIN

@class JSAlertAction;

typedef void(^JSAction_Block)( JSAlertAction *action);

@interface JSAlertAction : NSObject

/**
 初始化工厂方法

 @param models 多选项模型

 @return JSAlertAction对象
 */
+ (instancetype)multiSelectAlertActionWithMutiModels:(NSArray <JSAlertMultiModel *> *)models;

@property (nonatomic, strong , readonly)NSArray <JSAlertMultiModel *> *models;//模型

@end

NS_ASSUME_NONNULL_END
