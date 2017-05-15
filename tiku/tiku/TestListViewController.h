//
//  TestListViewController.h
//  Accountant
//
//  Created by aaa on 2017/3/18.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TestListTypeChapterTest = 0,
    TestListTypeError
}TestListType;

@interface TestListViewController : UIViewController

@property (nonatomic,assign) TestListType    listType;

@property (nonatomic,strong) NSString       *cateName;
@property (nonatomic,assign) int             cateId;

@end
