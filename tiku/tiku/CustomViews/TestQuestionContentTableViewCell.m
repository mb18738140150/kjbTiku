//
//  TestQuestionContentTableViewCell.m
//  Accountant
//
//  Created by aaa on 2017/3/24.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestQuestionContentTableViewCell.h"
#import "CommonMacro.h"
#import "UIMacro.h"
#import "UIUtility.h"
#import "TestMacro.h"

@implementation TestQuestionContentTableViewCell

- (void)resetWithInfo:(NSDictionary *)infoDic
{
    [self.testContentLabel removeFromSuperview];
    [self.testTypeLabel removeFromSuperview];
    
    self.backgroundColor = kBackgroundLightGrayColor;
    
    UIFont *font = kMainFont;
    
    CGFloat height = [UIUtility getSpaceLabelHeght:[infoDic objectForKey:kTestQuestionContent] font:font width:(kScreenWidth - 40)];
    
    self.testTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth, 20)];
    self.testTypeLabel.text = [NSString stringWithFormat:@"[%@]",[infoDic objectForKey:kTestQuestionType]];
    self.testTypeLabel.font = kMainFont;
    self.testTypeLabel.textColor = kCommonNavigationBarColor;
    [self addSubview:self.testTypeLabel];
    
    self.testContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, kScreenWidth - 40, height)];
    
    NSString *content = [infoDic objectForKey:kTestQuestionContent];
    NSMutableString *contentStr = [NSMutableString stringWithString:content];
    while (1) {
        if ([contentStr containsString:@"&nbsp;"] != 0) {
            NSRange range = [content rangeOfString:@"&nbsp;"];
            [contentStr deleteCharactersInRange:range];
        }else{
            break;
        }
    }
    
    self.testContentLabel.attributedText = [UIUtility getSpaceLabelStr:contentStr withFont:font];
    self.testContentLabel.numberOfLines = 100000;
    self.testContentLabel.font = font;
    self.testContentLabel.textColor = kMainTextColor_100;
    self.testContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:self.testContentLabel];
    
    [self.questionCountLabel removeFromSuperview];
    [self.questionCurrentLabel removeFromSuperview];
    
    self.questionCurrentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-120, 0, 60, 20)];
    self.questionCurrentLabel.textAlignment = NSTextAlignmentRight;
    self.questionCurrentLabel.text = [NSString stringWithFormat:@"%d",self.questionCurrentIndex+1];
    self.questionCurrentLabel.textColor = kCommonNavigationBarColor;
    self.questionCurrentLabel.font = kMainFont;
    [self addSubview:self.questionCurrentLabel];
    
    self.questionCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-60, 0, 60, 20)];
    self.questionCountLabel.textAlignment = NSTextAlignmentLeft;
    self.questionCountLabel.text = [NSString stringWithFormat:@" / %d",self.questionTotalCount];
    self.questionCountLabel.textColor = [UIColor grayColor];
    self.questionCountLabel.font = kMainFont;
    [self addSubview:self.questionCountLabel];
}

@end
