//
//  LeaningprocessTableViewCell.m
//  tiku
//
//  Created by aaa on 2017/5/9.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "LeaningprocessTableViewCell.h"
#import "UIMacro.h"
#define kSpace 15

@implementation LeaningprocessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)resetSubviews
{
    [self.processView removeFromSuperview];
    [self.processLabel removeFromSuperview];
    [self.leanContinuBT removeFromSuperview];
    self.backgroundColor = kBackgroundGrayColor;
    self.processView = [[ProcessView alloc]initWithFrame:CGRectMake(kSpace, kSpace, (kScreenWidth - 3*kSpace) / 3 * 2, 20)];
    self.processView.backgroundColor = kMainTextColor_200;
    self.processView.progress = 0.5;
    [self.contentView addSubview:self.processView];
    
    self.processLabel = [[UILabel alloc]initWithFrame:self.processView.frame];
    self.processLabel.backgroundColor = [UIColor clearColor];
    self.processLabel.text = @"学习进度";
    self.processLabel.textColor = [UIColor whiteColor];
    self.processLabel.textAlignment = 1;
    self.processLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.processLabel];
    
    
    
    self.leanContinuBT = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leanContinuBT.frame = CGRectMake(CGRectGetMaxX(self.processView.frame) + kSpace, 15, (kScreenWidth - 3*kSpace) / 3, 20);
    [self.leanContinuBT setTitle:@"继续上次学习" forState:UIControlStateNormal ];
    self.leanContinuBT.layer.cornerRadius = 3;
    self.leanContinuBT.layer.masksToBounds = YES;
    self.leanContinuBT.backgroundColor = kCommonMainColor;
    [self.leanContinuBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leanContinuBT.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.leanContinuBT];
    [self.leanContinuBT addTarget:self action:@selector(leanContinuAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leanContinuAction
{
    if (self.learnContinuBlock) {
        self.learnContinuBlock();
    }
}

@end
