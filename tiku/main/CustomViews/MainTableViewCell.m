//
//  MainTableViewCell.m
//  tiku
//
//  Created by aaa on 2017/5/12.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWithName:(NSString *)title icon:(NSString *)icon
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.iconImageView.image = [UIImage imageNamed:icon];
    self.titleLabel.text = title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
