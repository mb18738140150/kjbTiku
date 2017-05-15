//
//  CommunityTableViewCell.h
//  tiku
//
//  Created by aaa on 2017/5/12.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityTableViewCell : UITableViewCell

//传入的日期是否是计算过的
@property (nonatomic,assign) BOOL            isCalculatedDate;
//是否显示全问题内容
@property (nonatomic,assign) BOOL            isShowFullContent;

@property (nonatomic,assign) BOOL            isQuestionDetail;

- (void)resetCellWithInfo:(NSDictionary *)dic;


@end
