//
//  JSAlertMultiCell.m
//  AlertView
//
//  Created by Milton on 17/9/23.
//  Copyright © 2017年 Milton. All rights reserved.
//

#import "JSAlertMultiCell.h"

@interface JSAlertMultiCell ()

@property (nonatomic, strong)UIImageView *iconImageView;

@property (nonatomic, strong)UILabel *titleLB;

@end

@implementation JSAlertMultiCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _iconImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconImageView];
        
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = [UIColor blackColor];
        _titleLB.font = [UIFont systemFontOfSize:js_height(15)];
        [self.contentView addSubview:_titleLB];
        
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLB.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLayoutConstraint *title_constrint1 = [NSLayoutConstraint constraintWithItem:_titleLB attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *title_constrint2 = [NSLayoutConstraint constraintWithItem:_titleLB attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:js_height(-16)];
    NSLayoutConstraint *title_constrint3 = [NSLayoutConstraint constraintWithItem:_titleLB attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:js_height(21)];
//    title_constrint1.active  = YES;
//    title_constrint2.active  = YES;
//    title_constrint3.active  = YES;
    [self.contentView addConstraints:@[title_constrint1,title_constrint2,title_constrint3]];
    
    NSLayoutConstraint *imageView_constrint1 = [NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_titleLB attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *imageView_constrint2 = [NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_titleLB attribute:NSLayoutAttributeTop multiplier:1 constant:js_height(-4)];
    
//    imageView_constrint1.active = YES;
//    imageView_constrint2.active = YES;
    [self.contentView addConstraints:@[imageView_constrint1,imageView_constrint2]];
    
}

- (void)setModel:(JSAlertMultiModel *)model{
    _model = model;
    
    _iconImageView.image = [UIImage imageNamed:model.imageName];
    _titleLB.text = model.title;
    
}

@end
