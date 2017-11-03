//
//  MainViewController.m
//  JSAlertController
//
//  Created by FengDing_Ping on 2017/11/3.
//  Copyright © 2017年 FengDing_Ping. All rights reserved.
//

#import "MainViewController.h"
#import "JSAlertSheetViewController.h"
#import "JSSheepPresentTransition.h"
#import "JSAlertAction.h"
#import "JSAlertMultiModel.h"

@interface MainViewController ()<JSAlertSheetViewControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"sheet" style:UIBarButtonItemStylePlain target:self action:@selector(sheetAction)];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"alert" style:UIBarButtonItemStylePlain target:self action:@selector(alertAction)];
    
}


#pragma mark - Sheet

- (void)alertAction{
    
}


#pragma mark - Sheet

- (void)sheetAction{
    
    JSSheepPresentTransition *transition = [[JSSheepPresentTransition alloc]init];
    JSAlertSheetViewController *alertSheet = [[JSAlertSheetViewController alloc]initWithTransition:transition];
    alertSheet.delegate = self;
    
    NSArray *titles = @[@"系统指定",@"高级专家",@"知名专家",@"指定专家"];
    NSArray *images = @[@"image1",@"image2",@"image3",@"image4"];
    
    NSMutableArray <JSAlertMultiModel *> *models = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSInteger i = 0; i < titles.count; i++) {
        JSAlertMultiModel *model = [JSAlertMultiModel new];
        model.title = titles[i];
        model.imageName = images[i];
        [models addObject:model];
    }
    JSAlertAction *action = [JSAlertAction multiSelectAlertActionWithMutiModels:[models copy]];
    [alertSheet addAction:action];
    [self presentViewController:alertSheet animated:YES completion:nil];
    
}


- (void)js_alertSheetViewController:(JSAlertSheetViewController *)alertController selectedIndex:(NSInteger)index{
    
    NSLog(@"%ld", index);
}


@end
