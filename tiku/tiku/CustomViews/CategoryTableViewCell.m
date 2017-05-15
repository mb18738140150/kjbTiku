//
//  CategoryTableViewCell.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "MainViewMacro.h"
#import "UIMacro.h"
#import "CommonMacro.h"
#import "CategoryView.h"

@interface CategoryTableViewCell ()

@property (nonatomic,strong) NSMutableArray         *categoryViews;
//@property (nonatomic,strong) UIView                 *bottomLineView;

@end

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)resetWithCategoryInfos:(NSArray *)infoArray
{
//    [self.bottomLineView removeFromSuperview];
    for (CategoryView *view in self.categoryViews) {
        [view removeFromSuperview];
    }
    self.backgroundColor = kBackgroundGrayColor;
    for (int i = 0; i < infoArray.count; i++) {
        CategoryView *cateView = [[CategoryView alloc] initWithFrame:CGRectMake(i%3 * (kScreenWidth/3), i/3 * (kCellHeightOfCategoryView+10)+10, (kScreenWidth/3), kCellHeightOfCategoryView)];
        NSDictionary *cateInfo = [infoArray objectAtIndex:i];
        cateView.categoryId = [[cateInfo objectForKey:kCourseCategoryId] intValue];
        cateView.pageType = self.pageType;
        cateView.categoryName = [cateInfo objectForKey:kCourseCategoryName];
        cateView.categoryCoverUrl = [cateInfo objectForKey:kCourseCategoryCoverUrl];
        [cateView setupContents];
        
        [self addSubview:cateView];
        [self.categoryViews addObject:cateView];
    }
/*    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 2*kCellHeightOfCategoryView + 30, kScreenWidth, 10)];
    self.bottomLineView.backgroundColor = UIRGBColor(240, 240, 240);
    [self addSubview:self.bottomLineView];*/
}



@end
