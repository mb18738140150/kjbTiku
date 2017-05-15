//
//  TestQuestionResultTableViewCell.m
//  Accountant
//
//  Created by aaa on 2017/3/24.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestQuestionResultTableViewCell.h"
#import "TestMacro.h"
#import "CommonMacro.h"
#import "UIMacro.h"

@implementation TestQuestionResultTableViewCell

- (void)resetWithInfo:(NSDictionary *)infoDic
{
    [self.myLabel removeFromSuperview];
    [self.myTextLabel removeFromSuperview];
    [self.correctLabel removeFromSuperview];
    [self.correctTextLabel removeFromSuperview];
    [self.bgView removeFromSuperview];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth-40, kHeightOfTestMyAnswer-20)];
    self.bgView.backgroundColor = kBackgroundGrayColor;
    [self addSubview:self.bgView];
    
    CGSize bgViewSize = self.bgView.frame.size;
    
    self.correctLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgViewSize.width/2, bgViewSize.height/2)];
    self.correctLabel.text = [infoDic objectForKey:kTestQuestionCorrectAnswersId];
    self.correctLabel.textColor = UIRGBColor(0, 165, 128);
    self.correctLabel.font = [UIFont systemFontOfSize:20];
    self.correctLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.correctLabel];
    
    self.correctTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.correctLabel.frame.origin.y + self.correctLabel.frame.size.height, bgViewSize.width/2, bgViewSize.height/2)];
    self.correctTextLabel.text = @"正确答案";
    self.correctTextLabel.font = kMainFont;
    self.correctTextLabel.textColor = kMainTextColor_100;
    self.correctTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.correctTextLabel];
    
    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.correctLabel.frame.origin.x+self.correctLabel.frame.size.width, 0, bgViewSize.width/2, bgViewSize.height/2)];
    self.myLabel.textColor = UIRGBColor(0, 165, 128);
    self.myLabel.font = [UIFont systemFontOfSize:20];
    self.myLabel.textAlignment = NSTextAlignmentCenter;
    NSArray *selectedArray = [infoDic objectForKey:kTestQuestionSelectedAnswers];
    NSMutableString *myStr = [[NSMutableString alloc] init];
    for (NSNumber *number in selectedArray) {
        [myStr appendString:[NSString stringWithFormat:@"%@",number]];
    }
    self.myLabel.text = myStr;
    [self.bgView addSubview:self.myLabel];
    
    self.myTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.correctTextLabel.frame.origin.x+self.correctTextLabel.frame.size.width, self.myLabel.frame.origin.y + self.myLabel.frame.size.height, bgViewSize.width/2, bgViewSize.height/2)];
    self.myTextLabel.text = @"我的答案";
    self.myTextLabel.font = kMainFont;
    self.myTextLabel.textColor = kMainTextColor_100;
    self.myTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.myTextLabel];
}


@end
