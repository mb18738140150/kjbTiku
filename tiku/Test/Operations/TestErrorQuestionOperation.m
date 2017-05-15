//
//  TestErrorQuestionOperation.m
//  Accountant
//
//  Created by aaa on 2017/3/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestErrorQuestionOperation.h"
#import "HttpRequestManager.h"
#import "TestChapterModel.h"
#import "CommonMacro.h"
#import "TestAnswerModel.h"

@interface TestErrorQuestionOperation ()<HttpRequestProtocol>

@end

@implementation TestErrorQuestionOperation

- (void)didRequestErrorQuestionWithSectionId:(int)sectionId andNotifiedObject:(id<TestModule_ErrorQuestionProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustTestErrorQuesitonWithSectionId:sectionId andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    NSArray *data = [successInfo objectForKey:@"data"];
    [self.currentTestSection removeAllQuestion];
    for (NSDictionary *dic in data) {
        TestQuestionModel *questionModel = [[TestQuestionModel alloc] init];
        questionModel.questionId = [[dic objectForKey:@"id"] intValue];
        questionModel.questionType = [dic objectForKey:@"questionType"];
        questionModel.questionContent = [dic objectForKey:@"question"];
        questionModel.questionComplain = [dic objectForKey:@"analysis"];
        questionModel.correctAnswerIds = [dic objectForKey:@"answer"];
        questionModel.questionIsCollected = [[dic objectForKey:@"isCollect"] boolValue];
        NSString *a = [dic objectForKey:@"answer"];
        NSString *str = [dic objectForKey:@"items"];
        NSArray *array = [str componentsSeparatedByString:@"<p>"];
        for (NSString *str1 in array) {
            NSArray *subArray = [str1 componentsSeparatedByString:@"</p>"];
            for (NSString *answerStr in subArray) {
                if ([answerStr class] != [NSNull class] && answerStr != nil && ![answerStr isEqualToString:@""]) {
                    TestAnswerModel *answer = [[TestAnswerModel alloc] init];
                    answer.answerContent = answerStr;
                    unichar c = [answerStr characterAtIndex:0];
                    answer.answerId = [NSString stringWithFormat:@"%c",c];
                    if ([a containsString:answer.answerId]) {
                        answer.isCorrectAnswer = YES;
                    }else{
                        answer.isCorrectAnswer = NO;
                    }
                    [questionModel.answers addObject:answer];
                    
                }
            }
        }
        [self.currentTestSection addQuestion:questionModel];
    }
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestErrorQuestionSuccess];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestErrorQuestionFailed:failInfo];
    }
}

@end
