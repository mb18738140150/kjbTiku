//
//  TestChapterQuestionViewController.h
//  Accountant
//
//  Created by aaa on 2017/3/22.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewQuestionModels.h"

typedef enum {
    TestQuestionTypeError = 0,
    TestQuestionTypeChapter,
    TestQuestionTypeMyWrong
}TestQuestionViewType;

@interface TestChapterQuestionViewController : UIViewController

@property (nonatomic,assign) TestQuestionViewType                questionType;


@end
