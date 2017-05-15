//
//  MainheadView.h
//  tiku
//
//  Created by aaa on 2017/5/12.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainheadView : UIView

@property (nonatomic, strong)UIImageView * backImageView;
@property (nonatomic, strong)UIImageView *iconImageView;
@property (strong, nonatomic)UILabel * nameLabel;
@property (nonatomic, strong)UIButton * signinBT;


- (instancetype)initWithFrame:(CGRect)frame;

-(void)reset;

@end
