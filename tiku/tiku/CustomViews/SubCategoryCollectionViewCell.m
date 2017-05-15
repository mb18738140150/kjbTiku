//
//  SubCategoryCollectionViewCell.m
//  Accountant
//
//  Created by aaa on 2017/3/21.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "SubCategoryCollectionViewCell.h"
#import "CommonMacro.h"
#import "UIMacro.h"

@interface SubCategoryCollectionViewCell ()

@property (nonatomic,strong) UIImageView                *imageView;
@property (nonatomic,strong) UILabel                    *titleLabel;

@end

@implementation SubCategoryCollectionViewCell

- (void)resetViewWithDic:(NSDictionary *)infoDic
{
    [self.imageView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    CGSize cellSize = self.frame.size;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cellSize.width/2 - 20, 10, 40, 40)];
    //        subImageView.backgroundColor = [UIColor grayColor];
    self.imageView.image = [UIImage imageNamed:[infoDic objectForKey:kTestCategoryImageName]];
    [self addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, cellSize.width, 20)];
    self.titleLabel.text = [infoDic objectForKey:kTestCategoryName];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = kMainTextColor_100;
    [self addSubview:self.titleLabel];
}

@end
