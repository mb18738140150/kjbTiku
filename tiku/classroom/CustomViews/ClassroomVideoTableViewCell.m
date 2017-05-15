//
//  ClassroomVideoTableViewCell.m
//  tiku
//
//  Created by aaa on 2017/5/12.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "ClassroomVideoTableViewCell.h"

@implementation ClassroomVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)reset:(NSInteger)index
{
    if(index % 2 == 0 )
    {
        self.lookVideoBT.backgroundColor = UIRGBColor(248, 86, 64);
        [self.lookVideoBT setTitle:@"￥528.0" forState:UIControlStateNormal];
    }
}

- (IBAction)lookVideoAction:(id)sender {
    
    
    
}

@end
