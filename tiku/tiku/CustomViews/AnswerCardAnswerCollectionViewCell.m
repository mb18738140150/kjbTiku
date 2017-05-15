//
//  AnswerCardAnswerCollectionViewCell.m
//  Accountant
//
//  Created by aaa on 2017/3/30.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "AnswerCardAnswerCollectionViewCell.h"
#import "UIMacro.h"
#import "CommonMacro.h"

@implementation AnswerCardAnswerCollectionViewCell

- (void)resetCellWithInfo:(NSDictionary *)infoDic
{
    self.dic = infoDic;
    [self.bgView removeFromSuperview];
    [self.answerLabel removeFromSuperview];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4-1, 40)];
    self.bgView.backgroundColor = kBackgroundGrayColor;
    self.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.bgView.layer.borderWidth = 1;
//    [self addSubview:self.bgView];
    
    self.answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/6/2 - 15, kScreenWidth/6/2 - 15, 30, 30)];
    self.answerLabel.backgroundColor = [UIColor clearColor];
    self.answerLabel.text = [NSString stringWithFormat:@"  %@.%@",[infoDic objectForKey:kTestQuestionIndex],[infoDic objectForKey:kTestQuestionAnswers]];
    self.answerLabel.text = [NSString stringWithFormat:@"%@",[infoDic objectForKey:kTestQuestionIndex]];
    self.answerLabel.font = [UIFont systemFontOfSize:14];
    self.answerLabel.textAlignment = NSTextAlignmentCenter;
    self.answerLabel.layer.cornerRadius = 15;
    self.answerLabel.layer.masksToBounds = YES;
    if ([[infoDic objectForKey:kTestQuestionAnswers] isEqualToString:@"未作答"]) {
        self.answerLabel.layer.borderColor = [UIColor colorWithWhite:.9 alpha:1].CGColor;
        self.answerLabel.layer.borderWidth = 2;
    }else
    {
        self.answerLabel.backgroundColor = kCommonNavigationBarColor;
        self.answerLabel.textColor = [UIColor whiteColor];
    }
    
    [self addSubview:self.answerLabel];
}

@end
