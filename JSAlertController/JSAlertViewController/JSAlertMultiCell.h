//
//  JSAlertMultiCell.h
//  AlertView
//
//  Created by Milton on 17/9/23.
//  Copyright © 2017年 Milton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSAlertMultiModel.h"

#define js_width( x ) [UIScreen mainScreen].bounds.size.width / 375 * x
#define js_height( y ) [UIScreen mainScreen].bounds.size.height / 667 * y

@interface JSAlertMultiCell : UICollectionViewCell

@property (nonatomic, strong)JSAlertMultiModel *model;

@end
