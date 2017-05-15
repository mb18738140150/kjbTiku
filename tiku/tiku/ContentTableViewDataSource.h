//
//  ContentTableViewDataSource.h
//  tiku
//
//  Created by aaa on 2017/5/9.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ContentTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,weak) NSArray              *catoryDataSourceArray;

@property (nonatomic,strong) NSArray            *mainQuestionArray;

@end
