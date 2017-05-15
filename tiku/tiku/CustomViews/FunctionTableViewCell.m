//
//  FunctionTableViewCell.m
//  tiku
//
//  Created by aaa on 2017/5/9.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "FunctionTableViewCell.h"
#import "UIMacro.h"

@implementation FunctionTableViewCell

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
    [self.chapterExerciseLB removeFromSuperview];
    [self.videoLB removeFromSuperview];
    
    self.backgroundColor = kBackgroundGrayColor;
    self.chapterExerciseLB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chapterExerciseLB.frame = CGRectMake(5, 5, (kScreenWidth - 15) / 2, 40);
    [self.chapterExerciseLB setTitle:@"章节练习" forState:UIControlStateNormal ];
    self.chapterExerciseLB.layer.borderColor = kMainTextColor_150.CGColor;
    self.chapterExerciseLB.layer.borderWidth = 1;
    self.chapterExerciseLB.backgroundColor = [UIColor whiteColor];
    [self.chapterExerciseLB setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
    self.chapterExerciseLB.titleLabel.font = kMainFont;
    [self.contentView addSubview:self.chapterExerciseLB];
    [self.chapterExerciseLB addTarget:self action:@selector(chapterExerciseAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.videoLB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.videoLB.frame = CGRectMake(CGRectGetMaxX(self.chapterExerciseLB.frame) + 5, 5, (kScreenWidth - 15) / 2, 40);
    [self.videoLB setTitle:@"学习视频" forState:UIControlStateNormal ];
    self.videoLB.layer.borderColor = kMainTextColor_150.CGColor;
    self.videoLB.layer.borderWidth = 1;
    self.videoLB.backgroundColor = [UIColor whiteColor];
    [self.videoLB setTitleColor:kMainTextColor_100 forState:UIControlStateNormal];
    self.videoLB.titleLabel.font = kMainFont;
    [self.contentView addSubview:self.videoLB];
    [self.videoLB addTarget:self action:@selector(leanVideoAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)chapterExerciseAction
{
    if (self.chapterExerciseBlock) {
        self.chapterExerciseBlock();
    }
}

- (void)leanVideoAction
{
    if (self.leanVideoBlock) {
        self.leanVideoBlock();
    }
}

@end
