//
//  TestSimulateListTableViewCell.h
//  Accountant
//
//  Created by aaa on 2017/3/28.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestSimulateListTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView            *iconImageView;
@property (nonatomic,strong) UILabel                *titleLabel;
@property (nonatomic,strong) UILabel                *totalCountLabel;

- (void)resetContentWithInfo:(NSDictionary *)dic;

@end
