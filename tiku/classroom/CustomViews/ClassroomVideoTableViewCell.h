//
//  ClassroomVideoTableViewCell.h
//  tiku
//
//  Created by aaa on 2017/5/12.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassroomVideoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cuorseImageView;
@property (weak, nonatomic) IBOutlet UILabel *coursenameLB;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacherNameLB;
@property (weak, nonatomic) IBOutlet UILabel *courseVideoLength;
@property (weak, nonatomic) IBOutlet UIButton *lookVideoBT;

- (void)reset:(NSInteger)index;

@end
