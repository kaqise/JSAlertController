//
//  JSAlertSheetViewController.m
//  AlertView
//
//  Created by Milton on 17/9/18.
//  Copyright © 2017年 Milton. All rights reserved.
//

#import "JSAlertSheetViewController.h"
#import "JSAlertMultiCell.h"



#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0  alpha:1.0]


@interface JSAlertSheetViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UIView *containerView;

@property (nonatomic, strong)JSAlertAction *multiSelectAction;

@property (nonatomic, strong)JSSheepPresentTransition *transition;

@property (nonatomic, strong)UIButton *cancelBtn;

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation JSAlertSheetViewController

- (instancetype)initWithTransition:(JSSheepPresentTransition *)transition{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = transition;
        self.transition = transition;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)addAction:(JSAlertAction *)action{
    self.multiSelectAction = action;
}

- (void)setupUI{
    
    UIView *backGround = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - js_height(150), [UIScreen mainScreen].bounds.size.width, js_height(146))];
    backGround.backgroundColor = [UIColor clearColor];
    [backGround setTag:1];
    [self.view addSubview:backGround];
    
    [backGround addSubview:self.collectionView];
    
    [backGround addSubview:self.cancelBtn];
    
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        //取消按钮
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(js_width(20),
                                                               js_height(150) - (js_height(4) + js_height(44)) ,
                                                               js_width(336),
                                                               js_height(44))];
        [_cancelBtn setBackgroundImage:[self cancelButtonBackgroundImageWithCollor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_cancelBtn setBackgroundImage:[self cancelButtonBackgroundImageWithCollor:[UIColor lightTextColor]] forState:UIControlStateHighlighted];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(js_width(20), 0, js_width(336), js_height(93)) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[JSAlertMultiCell class] forCellWithReuseIdentifier:@"JSAlertMultiCell"];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, js_width(336), js_height(93))];
        view.layer.contents = (id)[self collectionViewBackgroundImageWithColor:[UIColor whiteColor]].CGImage;
        _collectionView.backgroundView = view;
    }
    return _collectionView;
}

- (UIImage *)cancelButtonBackgroundImageWithCollor:(UIColor *)color{
    UIImage *image;
    CGRect rect = CGRectMake( 0 , 0 , js_width(336) , js_height(44));
    UIGraphicsBeginImageContext(rect.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(js_height(12) , js_height(12) )];
    [color setFill];
    [path fill];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)collectionViewBackgroundImageWithColor:(UIColor *)color{
    UIImage *image;
    CGRect rect = CGRectMake( 0 , 0 , js_width(336) , js_height(93));
    UIGraphicsBeginImageContext(rect.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(js_height(12) , js_height(12) )];
    [color setFill];
    [path fill];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.multiSelectAction.models.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JSAlertMultiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JSAlertMultiCell" forIndexPath:indexPath];
    cell.model  = self.multiSelectAction.models[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(js_width(84), js_height(93));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(js_alertSheetViewController:selectedIndex:)]) {
        [self.delegate js_alertSheetViewController:self selectedIndex:indexPath.row];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
