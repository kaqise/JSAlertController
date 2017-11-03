//
//  JSAlertAction.m
//  AlertView
//
//  Created by Milton on 17/9/18.
//  Copyright © 2017年 Milton. All rights reserved.
//

#import "JSAlertAction.h"

@interface JSAlertAction ()

@end

@implementation JSAlertAction

+ (instancetype)multiSelectAlertActionWithMutiModels:(NSArray<JSAlertMultiModel *> *)models{
    JSAlertAction *action = [[JSAlertAction alloc]init];
    action->_models = models;
    return action;
}


@end
