//
//  LeaningprocessTableViewCell.h
//  tiku
//
//  Created by aaa on 2017/5/9.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessView.h"

@interface LeaningprocessTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * processLabel;
@property (nonatomic, strong)UIButton *leanContinuBT;
@property (nonatomic, strong)ProcessView * processView;
@property (nonatomic, copy)void (^learnContinuBlock)();

- (void)resetSubviews;

@end
