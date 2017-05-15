//
//  BannerTableViewCell.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "BannerTableViewCell.h"
#import "UIMacro.h"
#import "MainViewMacro.h"
#import "SDCycleScrollView.h"

@interface BannerTableViewCell ()

@property (nonatomic,strong) SDCycleScrollView          *bannerScrollView;


@end

@implementation BannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)resetSubviews
{
    [self.bannerScrollView removeFromSuperview];
    self.bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kCellHeightOfBanner) imageNamesGroup:self.bannerImgUrlArray];
    self.bannerScrollView.autoScrollTimeInterval = 10;
    [self addSubview:self.bannerScrollView];
}

- (void)setupView
{
    self.bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kCellHeightOfBanner) imageNamesGroup:self.bannerImgUrlArray];
    self.bannerScrollView.autoScrollTimeInterval = 10;
    [self addSubview:self.bannerScrollView];
}



@end
