//
//  SimulateResultCollectionViewCell.m
//  Accountant
//
//  Created by aaa on 2017/4/5.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "SimulateResultCollectionViewCell.h"
#import "UIMacro.h"
#import "CommonMacro.h"

@implementation SimulateResultCollectionViewCell

- (void)resetCellWithinfo:(NSDictionary *)questionInfo
{
    self.backgroundColor = [UIColor whiteColor];
    [self.questionNumberLabel removeFromSuperview];
    [self.imageView removeFromSuperview];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 15, self.frame.size.height / 2 - 15, 30, 30)];
    self.imageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imageView];
    
    self.questionNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 15, self.frame.size.height / 2 - 15, 30, 30)];
    [self addSubview:self.questionNumberLabel];
    self.questionNumberLabel.textColor = [UIColor whiteColor];
    self.questionNumberLabel.font = [UIFont systemFontOfSize:15];
    self.questionNumberLabel.layer.cornerRadius = 15;
    self.questionNumberLabel.layer.masksToBounds = YES;
    self.questionNumberLabel.textAlignment = 1;
    if ([[questionInfo objectForKey:kTestQuestionIsAnswerCorrect] intValue]) {
        self.questionNumberLabel.backgroundColor = [UIColor clearColor];
        self.imageView.image = [UIImage imageNamed:@"simulateRightimage"];
    }else
    {
        self.questionNumberLabel.backgroundColor = [UIColor clearColor];
        self.imageView.image = [UIImage imageNamed:@"simulateWrongimage"];
    }
    
    if (![[questionInfo objectForKey:kTestQuestionIsAnswered] intValue]) {
        self.imageView.hidden = YES;
        self.questionNumberLabel.backgroundColor = [UIColor whiteColor];
        self.questionNumberLabel.textColor = [UIColor colorWithWhite:.4 alpha:1];
        self.questionNumberLabel.layer.borderColor = [UIColor colorWithWhite:.9 alpha:1].CGColor;
        self.questionNumberLabel.layer.borderWidth = 2;
    }
    
}

@end
