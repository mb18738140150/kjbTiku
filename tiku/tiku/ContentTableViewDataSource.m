//
//  ContentTableViewDataSource.m
//  tiku
//
//  Created by aaa on 2017/5/9.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "ContentTableViewDataSource.h"
#import "BannerTableViewCell.h"
#import "UIUtility.h"
#import "ImageManager.h"
#import "CategoryTableViewCell.h"
#import "FunctionTableViewCell.h"
#import "LeaningprocessTableViewCell.h"

@implementation ContentTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count;
    switch (section) {
        case 0:
            count = 1;
            break;
            
        case 1:
            count = 1;
            break;
            
        case 2:
            count = 1;
            break;
            
        case 3:
            count = 1;
            break;
            
        case 4:
            count = (int)self.mainQuestionArray.count;
            break;
        default:
            break;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *bannerCellName = @"bannerCell";
        BannerTableViewCell *bannerCell = (BannerTableViewCell *)[UIUtility getCellWithCellName:bannerCellName inTableView:tableView andCellClass:[BannerTableViewCell class]];
        bannerCell.bannerImgUrlArray = [[ImageManager sharedManager] getBannerImgURLStrings];
        [bannerCell resetSubviews];
        return bannerCell;
    }
    if (indexPath.section == 1) {
        static NSString *courseCategoryCellName = @"courseAllCategoryCell";
        CategoryTableViewCell *cell = (CategoryTableViewCell *)[UIUtility getCellWithCellName:courseCategoryCellName inTableView:tableView andCellClass:[CategoryTableViewCell class]];
        cell.pageType = PageMain;
        [cell resetWithCategoryInfos:self.catoryDataSourceArray];
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString *functionCellName = @"functionCell";
        FunctionTableViewCell *cell = (FunctionTableViewCell *)[UIUtility getCellWithCellName:functionCellName inTableView:tableView andCellClass:[FunctionTableViewCell class]];
        [cell resetSubviews];
        
        cell.chapterExerciseBlock = ^(){
            NSLog(@"章节练习");
        };
        
        cell.leanVideoBlock = ^(){
            NSLog(@"学习视频");
        };
        
        return cell;
    }
    if (indexPath.section == 3) {
        static NSString *learCellName = @"leanprocessCell";
        LeaningprocessTableViewCell *cell = (LeaningprocessTableViewCell *)[UIUtility getCellWithCellName:learCellName inTableView:tableView andCellClass:[LeaningprocessTableViewCell class]];
        [cell resetSubviews];
        cell.learnContinuBlock = ^(){
            NSLog(@"继续上次学习");
        };
        return cell;
    }
    
    return nil;
}



@end
