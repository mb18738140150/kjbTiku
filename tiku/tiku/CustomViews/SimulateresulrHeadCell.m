//
//  SimulateresulrHeadCell.m
//  Accountant
//
//  Created by aaa on 2017/4/5.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "SimulateresulrHeadCell.h"
#import "UIMacro.h"
#import "CommonMacro.h"

@implementation SimulateresulrHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithInfo:(NSDictionary *)dic
{
    NSDictionary * attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:25], NSForegroundColorAttributeName:UIRGBColor(255, 241, 0)};
    NSDictionary * attribute2 = @{NSForegroundColorAttributeName:UIRGBColor(26, 159, 215)};
    
    NSString * topRightStr = [NSString stringWithFormat:@"答对%ld道题", [[dic objectForKey:kRightquistionArr] count]];
    NSString * topTotalStr = [NSString stringWithFormat:@"共%ld道", [[dic objectForKey:kWrongquistionArr] count] + [[dic objectForKey:kRightquistionArr] count]];
    NSString * timeStr = [NSString stringWithFormat:@"用时%d秒", self.time];
    
    self.topRightCountLB.attributedText = [self getCountAttribute:attribute1 string:topRightStr andCount:[[dic objectForKey:kRightquistionArr] count]];
    self.topTotalLB.text = topTotalStr;
    self.roralnumberLabel.attributedText = [self getCountAttribute:attribute2 string:topTotalStr andCount:[[dic objectForKey:kWrongquistionArr] count] + [[dic objectForKey:kRightquistionArr] count]];
    self.wrongnumberLabel.attributedText = [self getCountAttribute:attribute2 string:topRightStr andCount:[[dic objectForKey:kRightquistionArr] count]];
    self.rateLabel.attributedText = [self getCountAttribute:attribute2 string:timeStr andCount:(NSUInteger)self.time];
    
    CGFloat rate = [[dic objectForKey:kRightquistionArr] count] * 1.0 / ([[dic objectForKey:kWrongquistionArr] count] + [[dic objectForKey:kRightquistionArr] count]);
    if(rate >= 0.6)
    {
        self.iconImageView.image = [UIImage imageNamed:@"simulateresultGood"];
    }else
    {
        self.iconImageView.image = [UIImage imageNamed:@"simulateresultBad"];
    }
    
    
}

- (NSString *)getCreatTimeStr
{
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY-MM-dd/hh:mm";
    NSString * dateStr = [formatter stringFromDate:date];
    NSString * str = [@"生成报告时间:\n" stringByAppendingString:dateStr];
    return str;
}

- (NSMutableAttributedString *)getCountAttribute:(NSDictionary *)attribute string:(NSString *)str andCount:(NSUInteger)count
{
    NSString * string = [NSString stringWithFormat:@"%ld",count];
    
    NSRange range = [str rangeOfString:string];
    
    NSMutableAttributedString * astring = [[NSMutableAttributedString alloc]initWithString:str];
    
    [astring setAttributes:attribute range:range];
    
    return astring;
}



@end
