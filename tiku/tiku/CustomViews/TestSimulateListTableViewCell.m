//
//  TestSimulateListTableViewCell.m
//  Accountant
//
//  Created by aaa on 2017/3/28.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestSimulateListTableViewCell.h"
#import "UIMacro.h"
#import "CommonMacro.h"
#import "UIUtility.h"

@implementation TestSimulateListTableViewCell

- (void)resetContentWithInfo:(NSDictionary *)dic
{
    [self.iconImageView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    [self.totalCountLabel removeFromSuperview];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    self.iconImageView.image = [UIImage imageNamed:@"mo.png"];
    [self addSubview:self.iconImageView];
    
    CGFloat height = [UIUtility getHeightWithText:[dic objectForKey:kTestSimulateName] font:[UIFont systemFontOfSize:15] width:kScreenWidth-90];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 40 -  height / 2, kScreenWidth - 80 -10, height)];
    self.titleLabel.numberOfLines = 10000;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = kMainTextColor_100;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.text = [dic objectForKey:kTestSimulateName];
    [self addSubview:self.titleLabel];
    
    self.totalCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-90, 55, 80, 20)];
    self.totalCountLabel.font = [UIFont systemFontOfSize:15];
    self.totalCountLabel.text = [NSString stringWithFormat:@"共%@道题",[dic objectForKey:kTestSimulateQuestionCount]];
    self.totalCountLabel.textColor = UIRGBColor(180, 180, 180);
//    [self addSubview:self.totalCountLabel];
}
@end
