//
//  MainheadView.m
//  tiku
//
//  Created by aaa on 2017/5/12.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "MainheadView.h"

@implementation MainheadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.backImageView.image = [UIImage imageNamed:@"main_headbg2"];
    self.backImageView.userInteractionEnabled = YES;
    [self addSubview:self.backImageView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 35, 75, 69, 69)];
    self.iconImageView.image = [UIImage imageNamed:@"main_head4"];
    self.iconImageView.userInteractionEnabled = YES;
    [self addSubview:self.iconImageView];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame) + 13, kScreenWidth, 15)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = 1;
    self.nameLabel.font = kMainFont;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.nameLabel];
    
    self.signinBT = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signinBT.frame = CGRectMake(kScreenWidth / 2 - 44, CGRectGetMaxY(self.nameLabel.frame) + 10, 88, 28);
    self.signinBT.backgroundColor = [UIColor whiteColor];
    [self.signinBT setTitleColor:UIColorFromRGB(0x01A4FF) forState:UIControlStateNormal];
    self.signinBT.titleLabel.font = kMainFont;
    self.signinBT.layer.cornerRadius = 3;
    self.signinBT.layer.masksToBounds = YES;
    [self.signinBT addTarget:self action:@selector(signinAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.signinBT];
}

-(void)reset
{
    self.nameLabel.text = @"测试账号";
    [self.signinBT setTitle:@"签到+1" forState:UIControlStateNormal];
}

- (void)signinAction:(UIButton *)button
{
    NSLog(@"signin");
}

@end
