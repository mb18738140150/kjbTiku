//
//  CommunityTableViewCell.m
//  tiku
//
//  Created by aaa on 2017/5/12.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "CommunityTableViewCell.h"

@interface CommunityTableViewCell()

@property (nonatomic,strong) UIImageView            *headerImageView;
@property (nonatomic,strong) UILabel                *nameLabel;
@property (nonatomic,strong) UILabel                *timeLabel;

@property (nonatomic,strong) UILabel                *questionContentLabel;

@property (nonatomic,strong) UILabel                *seePeopleCountLabel;
@property (nonatomic,strong) NSDictionary           *cellInfoDic;
@property (nonatomic,strong) UIView                 *bottomLineView;

@property (nonatomic,strong) UIImageView            *imageView1;
@property (nonatomic,strong) UIImageView            *imageView2;
@property (nonatomic,strong) UIImageView            *imageView3;

@property (nonatomic, strong)UIImageView * praiseImageView;
@property (nonatomic, strong)UILabel *praiseLabel;
@property (nonatomic, strong)UIImageView *commentImageView;
@property (nonatomic, strong)UILabel  *commentLabel;

@end

@implementation CommunityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)removeAllContentViews
{
    [self.headerImageView removeFromSuperview];
    [self.questionContentLabel removeFromSuperview];
    [self.timeLabel removeFromSuperview];
    [self.seePeopleCountLabel removeFromSuperview];
    [self.timeLabel removeFromSuperview];
    [self.bottomLineView removeFromSuperview];
    [self.nameLabel removeFromSuperview];
    [self.praiseImageView removeFromSuperview];
    [self.praiseLabel removeFromSuperview];
    [self.commentImageView removeFromSuperview];
    [self.commentLabel removeFromSuperview];
}

- (void)resetCellWithInfo:(NSDictionary *)dic
{
    [self removeAllContentViews];
    if (dic.allKeys.count == 0) {
        return;
    }
    self.cellInfoDic = dic;
    
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 ,kScreenWidth,2)];
    self.bottomLineView.backgroundColor = kTableViewCellSeparatorColor;
    [self addSubview:self.bottomLineView];
    
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 2 + kMainSpace, kHeightOfCellHeaderImage, kHeightOfCellHeaderImage)];
    if ([[self.cellInfoDic objectForKey:kQuestionQuizzerHeaderImageUrl] class] == [NSNull class] || [self.cellInfoDic objectForKey:kQuestionQuizzerHeaderImageUrl] == nil || [[self.cellInfoDic objectForKey:kQuestionQuizzerHeaderImageUrl] isEqualToString:@""]) {
        self.headerImageView.image = [UIImage imageNamed:@"stuhead.gif"];
    }else{
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[self.cellInfoDic objectForKey:kQuestionQuizzerHeaderImageUrl]] placeholderImage:[UIImage imageNamed:@"community_head2"]];
    }
    self.headerImageView.layer.cornerRadius = self.headerImageView.frame.size.width/2;
    self.headerImageView.clipsToBounds = YES;
    [self addSubview:self.headerImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x + self.headerImageView.frame.size.width + 10, 20, kScreenWidth - 80, 20)];
    NSString *showName;
    NSString *userName = [dic objectForKey:kQuestionQuizzerUserName];
    if ([userName class] == [NSNull class] || userName.length <= 4) {
        showName = @"简单的快乐";
    }else{
        showName = [NSString stringWithFormat:@"%@****",[userName substringToIndex:userName.length-4]];
    }
    self.nameLabel.text = showName;
    self.nameLabel.textColor = kMainTextColor;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x + self.headerImageView.frame.size.width + 10, 43, kScreenWidth - 100, 20)];
    if (self.isCalculatedDate) {
        self.timeLabel.text = [self.cellInfoDic objectForKey:kQuestionTime];
    }else{
        self.timeLabel.text = [self.cellInfoDic objectForKey:kQuestionTime];
    }
    self.timeLabel.textColor = UIRGBColor(112, 112, 112);
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.timeLabel];
    
    CGFloat height;
    CGFloat maxHeight = 80;
    UIFont *font = kMainFont;
    
    
    CGFloat contentHeight = [UIUtility getHeightWithText:[self.cellInfoDic objectForKey:kQuestionContent] font:font width:kScreenWidth - 40];
    
    if (self.isShowFullContent) {
        height = contentHeight;
    }else{
        if (contentHeight > maxHeight) {
            height = 80;
        }else{
            height = contentHeight;
        }
    }
    
    self.questionContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.headerImageView.frame.origin.y + self.headerImageView.frame.size.height + kMainSpace, kScreenWidth - 40, height)];
    self.questionContentLabel.text = [self.cellInfoDic objectForKey:kQuestionContent];
    if (self.isShowFullContent == YES) {
        self.questionContentLabel.numberOfLines = 10000;
    }else{
        self.questionContentLabel.numberOfLines = 4;
    }
    self.questionContentLabel.font = kMainFont;
    self.questionContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.questionContentLabel.textColor = kMainTextColor_100;
    [self addSubview:self.questionContentLabel];

    if (self.isQuestionDetail) {
        NSArray *imgs = [dic objectForKey:kQuestionImgStr];
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.questionContentLabel.frame.origin.y + self.questionContentLabel.frame.size.height + 10, kCommunityImageWidth, kCommunityImageWidth)];
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(15 + kCommunityImageWidth + 4, self.questionContentLabel.frame.origin.y + self.questionContentLabel.frame.size.height + 10, kCommunityImageWidth, kCommunityImageWidth)];
        self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(15 + (kCommunityImageWidth + 4)*2, self.questionContentLabel.frame.origin.y + self.questionContentLabel.frame.size.height + 10, kCommunityImageWidth, kCommunityImageWidth)];
        if (imgs.count == 1) {
            [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imgs[0]] placeholderImage:[UIImage imageNamed:@"community_head2"]];
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
            [self.imageView1 addGestureRecognizer:tap1];
            self.imageView1.userInteractionEnabled = YES;
            [self addSubview:self.imageView1];
        }
        if (imgs.count == 2) {
            [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imgs[0]] placeholderImage:[UIImage imageNamed:@"community_head2"]];
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
            [self.imageView1 addGestureRecognizer:tap1];
            self.imageView1.userInteractionEnabled = YES;
            
            [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:imgs[1]] placeholderImage:[UIImage imageNamed:@"community_head2"]];
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
            [self.imageView2 addGestureRecognizer:tap2];
            self.imageView2.userInteractionEnabled = YES;
            
            [self addSubview:self.imageView1];
            [self addSubview:self.imageView2];
        }
        if (imgs.count == 3) {
            [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imgs[0]] placeholderImage:[UIImage imageNamed:@"community_head2"]];
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
            [self.imageView1 addGestureRecognizer:tap1];
            self.imageView1.userInteractionEnabled = YES;
            
            [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:imgs[1]] placeholderImage:[UIImage imageNamed:@"community_head2"]];
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
            [self.imageView2 addGestureRecognizer:tap2];
            self.imageView2.userInteractionEnabled = YES;
            
            [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:imgs[2]] placeholderImage:[UIImage imageNamed:@"community_head2"]];
            UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3)];
            [self.imageView3 addGestureRecognizer:tap3];
            self.imageView3.userInteractionEnabled = YES;
            
            [self addSubview:self.imageView1];
            [self addSubview:self.imageView2];
            [self addSubview:self.imageView3];
        }
        
        self.praiseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 107, self.imageView1.hd_y + self.imageView1.hd_height + 10, 15, 15)];
        
    }else{
        
        self.praiseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 107, self.questionContentLabel.hd_y + self.questionContentLabel.hd_height + 10, 15, 15)];
        
    }
    
    self.praiseImageView.image = [UIImage imageNamed:@"community_点赞"];
    [self addSubview:self.praiseImageView];
    
    self.praiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.praiseImageView.frame) + 6, self.praiseImageView.hd_y, 30, 15)];
    self.praiseLabel.textColor = kMainTextColor_100;
    self.praiseLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:kQuestionSeePeopleCount]];
    self.praiseLabel.font  = [UIFont systemFontOfSize:10];
    [self addSubview:self.praiseLabel];
    
    self.commentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 51, self.praiseImageView.hd_y, 15, 15)];
    self.commentImageView.image = [UIImage imageNamed:@"community_评论"];
    [self addSubview:self.commentImageView];
    
    self.commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.commentImageView.frame) + 6, self.praiseImageView.hd_y, 30, 15)];
    self.commentLabel.textColor = kMainTextColor_100;
    self.commentLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:kQuestionReplyCount]];
    self.commentLabel.font  = [UIFont systemFontOfSize:10];
    [self addSubview:self.commentLabel];
    
//    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.praiseImageView.frame.origin.y + self.praiseImageView.frame.size.height + 8 ,kScreenWidth-20,2)];
//    self.bottomLineView.backgroundColor = kTableViewCellSeparatorColor;
//    [self addSubview:self.bottomLineView];
}

- (void)tap1
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfQuestionImageClick object:self.imageView1.image];
}

- (void)tap2
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfQuestionImageClick object:self.imageView2.image];
}

- (void)tap3
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfQuestionImageClick object:self.imageView3.image];
}
@end
