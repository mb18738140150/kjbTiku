//
//  SimulateresulrHeadCell.h
//  Accountant
//
//  Created by aaa on 2017/4/5.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimulateresulrHeadCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *topRightCountLB;
@property (weak, nonatomic) IBOutlet UILabel *topTotalLB;

@property (weak, nonatomic) IBOutlet UILabel *roralnumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *wrongnumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (nonatomic, assign)int time;

- (void)resetWithInfo:(NSDictionary *)dic;

@end
