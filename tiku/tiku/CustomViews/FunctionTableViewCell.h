//
//  FunctionTableViewCell.h
//  tiku
//
//  Created by aaa on 2017/5/9.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionTableViewCell : UITableViewCell

@property (nonatomic, strong)UIButton * chapterExerciseLB;
@property (nonatomic, strong)UIButton * videoLB;

@property (nonatomic, copy)void(^chapterExerciseBlock)();
@property (nonatomic, copy)void(^leanVideoBlock)();

- (void)resetSubviews;
@end
