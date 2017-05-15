//
//  TestManager.m
//  Accountant
//
//  Created by aaa on 2017/3/17.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestManager.h"
#import "TestAllCategoryOperation.h"
#import "TestChapterOperation.h"
#import "TestSectionQuestionOperation.h"
#import "TestSimulateInfoOperation.h"
#import "TestSimulateQuestionOperation.h"
#import "TestSimulateScoreOperation.h"
#import "CommonMacro.h"
#import "TestErrorInfoOperation.h"
#import "TestErrorQuestionOperation.h"
#import "TestMyWrongQuestionOperation.h"
#import "TestMyWrongQuestionInfoOperation.h"
#import "TestMyCollectionQuestionOperation.h"
#import "TestUncollectionQuestionOperation.h"
#import "TestQuestionHistoryOperation.h"

@interface TestManager ()

@property (nonatomic,strong) TestModuleModels                   *testModuleModel;

@property (nonatomic,strong) TestAllCategoryOperation           *allCategoryOperation;
@property (nonatomic,strong) TestChapterOperation               *chapterOperation;
@property (nonatomic,strong) TestSectionQuestionOperation       *sectionQuestionOperation;
@property (nonatomic,strong) TestSimulateInfoOperation          *simulateInfoOperation;
@property (nonatomic,strong) TestSimulateQuestionOperation      *simulateQuestionOperation;
@property (nonatomic,strong) TestSimulateScoreOperation         *simulateScoreOperation;
@property (nonatomic,strong) TestErrorInfoOperation             *errorInfoOperation;
@property (nonatomic,strong) TestErrorQuestionOperation         *errorQuestionsOperation;
@property (nonatomic,strong) TestMyWrongQuestionOperation       *myWrongQuestionOperation;
@property (nonatomic,strong) TestMyWrongQuestionInfoOperation   *myWrongQuestionInfoOperation;
@property (nonatomic,strong) TestMyCollectionQuestionOperation  *collectQuestionOperation;
@property (nonatomic,strong) TestUncollectionQuestionOperation  *uncollectQuestionOperation;
@property (nonatomic,strong) TestQuestionHistoryOperation       *questionHistoryOperation;


@end

@implementation TestManager

+ (instancetype)sharedManager
{
    static TestManager *__manager__;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager__ = [[TestManager alloc] init];
    });
    return __manager__;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.testModuleModel = [[TestModuleModels alloc] init];
        
        self.allCategoryOperation = [[TestAllCategoryOperation alloc] init];
        self.allCategoryOperation.allCategoryArray = self.testModuleModel.testAllCategoryArray;
        
        self.chapterOperation = [[TestChapterOperation alloc] init];
        self.chapterOperation.testChapterArray = self.testModuleModel.testChapterArray;
        
        self.sectionQuestionOperation = [TestSectionQuestionOperation new];
        self.sectionQuestionOperation.currentTestSection = self.testModuleModel.currentTestSection;
        
        self.simulateInfoOperation = [TestSimulateInfoOperation new];
        self.simulateInfoOperation.simulateArray = self.testModuleModel.testSimulateArray;
        
        self.simulateQuestionOperation = [TestSimulateQuestionOperation new];
        self.simulateQuestionOperation.simulateModel = self.testModuleModel.currentSimulateModel;
        
        self.simulateScoreOperation = [TestSimulateScoreOperation new];
        self.simulateScoreOperation.simulateResultModel = self.testModuleModel.currentSimulateWrongModel;
        
        self.errorInfoOperation = [TestErrorInfoOperation new];
        self.errorInfoOperation.errorChapterArray = self.testModuleModel.testErrorArray;
        
        self.errorQuestionsOperation = [TestErrorQuestionOperation new];
        self.errorQuestionsOperation.currentTestSection= self.testModuleModel.currentTestSection;
        
        self.myWrongQuestionOperation = [TestMyWrongQuestionOperation new];
        self.myWrongQuestionOperation.myWrongChapterArray = self.testModuleModel.testErrorArray;
        
        self.myWrongQuestionInfoOperation = [TestMyWrongQuestionInfoOperation new];
        self.myWrongQuestionInfoOperation.currentTestSection = self.testModuleModel.currentTestSection;
        
        self.collectQuestionOperation = [TestMyCollectionQuestionOperation new];
        self.uncollectQuestionOperation = [TestUncollectionQuestionOperation new];
        
        self.questionHistoryOperation = [TestQuestionHistoryOperation new];
        self.questionHistoryOperation.moduleModel = self.testModuleModel;

    }
    return self;
}

- (void)didRequestTestAllCategoryWithNotifiedObject:(id<TestModule_AllCategoryProtocol>)notifiedObject
{
    [self.allCategoryOperation didRequestTestAllCategoryWithNotifiedObject:notifiedObject];
}

- (void)didRequesTestChapterInfoWithCategoryId:(int)cateId andNotifiedObject:(id<TestModule_ChapterInfoProtocol>)notifiedObject
{
    [self.chapterOperation didRequestTestChapterInfoWithCategoryId:cateId andNotifiedObject:notifiedObject];
}

- (void)didRequestTestSectionQuestionWithSection:(int)sectionId andNotifiedObject:(id<TestModule_SectionQuestionProtocol>)notifiedObject
{
    [self.sectionQuestionOperation didRequestSectionQuestionWithSectionId:sectionId andNotifiedObject:notifiedObject];
}

- (void)didRequestTestSimulateInfoWithCategoryId:(int)cateId andNotifiedObject:(id<TestModule_SimulateInfoProtocol>)notifiedObject
{
    [self.simulateInfoOperation didRequestTestSimulateInfoWithCategoryId:cateId andNotifiedObject:notifiedObject];
}

- (void)didRequestTestSimulateQuestionWithTestId:(int)testId andNotifiedObject:(id<TestModule_SimulateQuestionProtocol>)notifiedObject
{
    [self.simulateQuestionOperation didRequestSimulateQuestionWithTestId:testId andNotifiedObject:notifiedObject];
}

- (void)didRequestTestSimulateScoreWithInfo:(NSArray *)array andNotifiedObject:(id<TestModule_SimulateScoreProtocol>)notifiedObject
{
    [self.simulateScoreOperation didRequestSimulateScoreWithInfo:array andNotifedObject:notifiedObject];
}

- (void)didRequestTestErrorInfoWithCategoryId:(int)cateId andNotifiedObject:(id<TestModule_ErrorInfoProtocol>)notifiedObject
{
    [self.errorInfoOperation didRequestErrorInfoWithCategoryId:cateId andNotifiedObject:notifiedObject];
}

- (void)didRequestTestErrorQuestionWithSectionId:(int)sectionId andNotifiedObject:(id<TestModule_ErrorQuestionProtocol>)notifiedObject
{
    [self.errorQuestionsOperation didRequestErrorQuestionWithSectionId:sectionId andNotifiedObject:notifiedObject];
}

- (void)didRequestTestAddMyWrongQuestionWithQuestionId:(int)questionId
{
    [self.myWrongQuestionOperation didAddMyWrongQuestionWithQuestionId:questionId];
}

- (void)didRequestTestMyWrongQuestionChapterInfoWithCategoryId:(int)cateId andNotifiedObject:(id<TestModule_MyWrongQuestionInfoProtocol>)notifiedObject
{
    [self.myWrongQuestionOperation didRequesMyWrongChapterWithCategoryId:cateId andNotifiedObject:notifiedObject];
}

- (void)didRequestTestMyWrongQuestionListWithChapterId:(int)chapterId andNotifiedObject:(id<TestModule_MyWrongQuestionsListProtocol>)notifiedObject
{
    [self.myWrongQuestionInfoOperation didRequestMyWrongQuestionListWithChapterId:chapterId andNotifiedObject:notifiedObject];
}

- (void)didRequestTestCollectQuestionWithQuestionId:(int)questionId andNotifiedObject:(id<TestModule_CollectQuestionProtocol>)notifiedObject
{
    [self.collectQuestionOperation didCollectQuestionWithQuestionId:questionId andNotifiedObject:notifiedObject];
}

- (void)didRequestTestUncollectQuestionWithQuestionId:(int)questionId andNotifiedObject:(id<TestModule_UncollectQuestionProtocol>)notifiedObject
{
    [self.uncollectQuestionOperation didUncollectQuestionWithQuestionId:questionId andNotifiedObject:notifiedObject];
}

- (void)didRequestAddTestHistoryWithInfo:(NSDictionary *)infoDic
{
    [self.questionHistoryOperation didRequesAddQuestionHistoryWithInfo:infoDic andNotifedObject:nil];
}

- (void)didRequestAddTestHistoryDetailWithInfo:(NSDictionary *)infoDic
{
    [self.questionHistoryOperation didRequestAddQuestionHistoryDetailWithInfo:infoDic];
}

- (NSArray *)getChapterInfoArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (TestChapterModel *cModel in self.testModuleModel.testChapterArray) {
        NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
        [dic1 setObject:cModel.chapterName forKey:kTestChapterName];
        [dic1 setObject:@(cModel.chapterId) forKey:kTestChapterId];
        [dic1 setObject:@(cModel.chapterQuestionCount) forKey:kTestChapterQuestionCount];
        NSMutableArray *sArray = [[NSMutableArray alloc] init];
        for (TestSectionModel *sModel in cModel.sectionArray) {
            NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
            [dic2 setObject:sModel.sectionName forKey:kTestSectionName];
            [dic2 setObject:@(sModel.sectionId) forKey:kTestSectionId];
            [dic2 setObject:@(sModel.sectionQuestionCount) forKey:kTestSectionQuestionCount];
            [sArray addObject:dic2];
        }
        [dic1 setObject:sArray forKey:kTestChapterSectionArray];
        
        [array addObject:dic1];
    }
    return array;
}

- (NSArray *)getSimulateInfoArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (TestSimulateModel *model in self.testModuleModel.testSimulateArray) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:model.simulateName forKey:kTestSimulateName];
        [dic setObject:@(model.simulateId) forKey:kTestSimulateId];
        [dic setObject:@(model.simulateQuestionCount) forKey:kTestSimulateQuestionCount];
        [array addObject:dic];
    }
    return array;
}

- (NSArray *)getErrorInfoArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (TestChapterModel *model in self.testModuleModel.testErrorArray) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@(model.chapterId) forKey:kTestChapterId];
        [dic setObject:@(model.chapterQuestionCount) forKey:kTestChapterQuestionCount];
        [dic setObject:model.chapterName forKey:kTestChapterName];
        [array addObject:dic];
    }
    return array;
}

- (NSArray *)getMyWrongChapterInfoArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (TestChapterModel *model in self.testModuleModel.testErrorArray) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@(model.chapterId) forKey:kTestChapterId];
        [dic setObject:@(model.chapterQuestionCount) forKey:kTestChapterQuestionCount];
        [dic setObject:model.chapterName forKey:kTestChapterName];
        [array addObject:dic];
    }
    return array;
}

- (void)nextQuestion
{
    [self.testModuleModel nextQuestion];
}

- (void)previousQuestion
{
    [self.testModuleModel previousQuestion];
}

- (void)collectCurrentQuestion
{
    self.testModuleModel.colectModelType = self.colectType;
    [self.testModuleModel collectQuestionAtIndex:[self getCurrentQuestionIndex]];
}

- (void)uncollectCurrentQuestion
{
    self.testModuleModel.colectModelType = self.colectType;
    [self.testModuleModel uncollectQuestionAtIndex:[self getCurrentQuestionIndex]];
}

- (int)getCurrentQuestionIndex
{
    return self.testModuleModel.currentQuestionIndex;
}

- (void)resetCurrentQuestionInfos
{
    self.testModuleModel.currentQuestionIndex = 0;
}

- (void)resetCurrentQuestionInfoswith:(int)index
{
    self.testModuleModel.currentQuestionIndex = index;
}

- (int)getTestSectionTotalCount
{
    return (int)self.testModuleModel.currentTestSection.questionArray.count;
}

- (void)submitAnswers:(NSMutableArray *)answerArray andQuestionIndex:(int)questionIndex
{
    [self.testModuleModel submitSectionQuestionAnswers:answerArray andIndex:questionIndex];
}

- (void)submitSimulateAnswers:(NSMutableArray *)answerArray andQuestionIndex:(int)questionIndex
{
    [self.testModuleModel submitSimulateQuestionAnswers:answerArray andIndex:questionIndex];
}

- (int)getTestSimulateTotalCount
{
    return (int)self.testModuleModel.currentSimulateModel.questionArray.count;
}

- (int)getTestSimulateWrongTotalCount
{
    return (int)self.testModuleModel.currentSimulateWrongModel.questionArray.count;
}

- (int)getLogId
{
    return self.testModuleModel.logId;
}

- (NSDictionary *)getCurrentSimulateQuestionInfo
{
    TestQuestionModel *questionModel = [self.testModuleModel.currentSimulateModel.questionArray objectAtIndex:self.testModuleModel.currentQuestionIndex];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@(questionModel.questionId) forKey:kTestQuestionId];
    [dic setObject:questionModel.questionContent forKey:kTestQuestionContent];
    [dic setObject:questionModel.questionComplain forKey:kTestQuestionComplain];
    [dic setObject:questionModel.questionType forKey:kTestQuestionType];
    [dic setObject:questionModel.correctAnswerIds forKey:kTestQuestionCorrectAnswersId];
    [dic setObject:@(questionModel.questionIsAnswered) forKey:kTestQuestionIsAnswered];
    [dic setObject:@(questionModel.questionIsCollected) forKey:kTestQuestionIsCollected];
    [dic setObject:questionModel.caseInfo forKey:kQuestionCaseInfo];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (TestAnswerModel *answerModel in questionModel.answers) {
        NSMutableDictionary *dic1 = [NSMutableDictionary new];
        [dic1 setObject:answerModel.answerContent forKey:kTestAnswerContent];
        [dic1 setObject:answerModel.answerId forKey:kTestAnserId];
        [array addObject:dic1];
    }
    [dic setObject:questionModel.selectArray forKey:kTestQuestionSelectedAnswers];
    [dic setObject:array forKey:kTestQuestionAnswers];
    return dic;
}

- (NSDictionary *)getCurrentSimulateWrongQuestionInfo
{
    TestQuestionModel *questionModel = [self.testModuleModel.currentSimulateWrongModel.questionArray objectAtIndex:self.testModuleModel.currentQuestionIndex];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@(questionModel.questionId) forKey:kTestQuestionId];
    [dic setObject:questionModel.questionContent forKey:kTestQuestionContent];
    [dic setObject:questionModel.questionComplain forKey:kTestQuestionComplain];
    [dic setObject:questionModel.questionType forKey:kTestQuestionType];
    [dic setObject:questionModel.correctAnswerIds forKey:kTestQuestionCorrectAnswersId];
    [dic setObject:@(questionModel.questionIsAnswered) forKey:kTestQuestionIsAnswered];
    [dic setObject:@(questionModel.questionIsCollected) forKey:kTestQuestionIsCollected];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (TestAnswerModel *answerModel in questionModel.answers) {
        NSMutableDictionary *dic1 = [NSMutableDictionary new];
        [dic1 setObject:answerModel.answerContent forKey:kTestAnswerContent];
        [dic1 setObject:answerModel.answerId forKey:kTestAnserId];
        [array addObject:dic1];
    }
    [dic setObject:questionModel.selectArray forKey:kTestQuestionSelectedAnswers];
    [dic setObject:array forKey:kTestQuestionAnswers];
    return dic;
}

- (NSDictionary *)getCurrentSectionQuestionInfo
{
    TestQuestionModel *questionModel = [self.testModuleModel.currentTestSection.questionArray objectAtIndex:self.testModuleModel.currentQuestionIndex];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@(questionModel.questionId) forKey:kTestQuestionId];
    [dic setObject:questionModel.questionContent forKey:kTestQuestionContent];
    [dic setObject:questionModel.questionComplain forKey:kTestQuestionComplain];
    [dic setObject:questionModel.questionType forKey:kTestQuestionType];
    [dic setObject:questionModel.correctAnswerIds forKey:kTestQuestionCorrectAnswersId];
    [dic setObject:@(questionModel.questionIsAnswered) forKey:kTestQuestionIsAnswered];
    [dic setObject:@(questionModel.questionIsCollected) forKey:kTestQuestionIsCollected];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (TestAnswerModel *answerModel in questionModel.answers) {
        NSMutableDictionary *dic1 = [NSMutableDictionary new];
        [dic1 setObject:answerModel.answerContent forKey:kTestAnswerContent];
        [dic1 setObject:answerModel.answerId forKey:kTestAnserId];
        [array addObject:dic1];
    }
    [dic setObject:questionModel.selectArray forKey:kTestQuestionSelectedAnswers];
    [dic setObject:array forKey:kTestQuestionAnswers];
    return dic;
}

- (NSArray *)getSimulateMyAnswersInfo
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    int i = 1;
    for (TestQuestionModel *model in self.testModuleModel.currentSimulateModel.questionArray) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        NSArray *selectedArray = model.selectArray;
        NSMutableString *myStr = [[NSMutableString alloc] init];
        
        if (selectedArray.count == 0) {
            [myStr appendFormat:@"未作答"];
        }else{
            for (NSNumber *number in selectedArray) {
                [myStr appendString:[NSString stringWithFormat:@"%@",number]];
            }
        }
        
        [dic setObject:myStr forKey:kTestQuestionAnswers];
        [dic setObject:@(i) forKey:kTestQuestionIndex];
        i++;
        [array addObject:dic];
    }
    return array;
}

- (NSDictionary *)getSimulateresult
{
    NSMutableDictionary * mdic = [NSMutableDictionary dictionary];
    
    NSMutableArray * rightQuestionArr = [NSMutableArray array];
    NSMutableArray * wrongQuestionArr = [NSMutableArray array];
    NSMutableArray * singleQuestionArr = [NSMutableArray array];
    NSMutableArray * multipleQuestionArr = [NSMutableArray array];
    NSMutableArray * judgeQuestionArr = [NSMutableArray array];
    
    [self.simulateScoreOperation.simulateResultModel removeAllQuestion];
    for (int i = 0; i < self.testModuleModel.currentSimulateModel.questionArray.count; i++) {
        TestQuestionModel * questionModel = self.testModuleModel.currentSimulateModel.questionArray[i];
        questionModel.questionNumber = i + 1;
        
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:@(questionModel.questionId) forKey:kTestQuestionId];
        [dic setObject:questionModel.questionContent forKey:kTestQuestionContent];
        [dic setObject:questionModel.questionComplain forKey:kTestQuestionComplain];
        [dic setObject:questionModel.questionType forKey:kTestQuestionType];
        [dic setObject:questionModel.correctAnswerIds forKey:kTestQuestionCorrectAnswersId];
        [dic setObject:@(questionModel.questionIsAnswered) forKey:kTestQuestionIsAnswered];
        [dic setObject:@(questionModel.questionIsCollected) forKey:kTestQuestionIsCollected];
        [dic setObject:@(questionModel.isAnsweredCorrect) forKey:kTestQuestionIsAnswerCorrect];
        [dic setObject:@(questionModel.questionNumber) forKey:kTestQuestionNumber];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (TestAnswerModel *answerModel in questionModel.answers) {
            NSMutableDictionary *dic1 = [NSMutableDictionary new];
            [dic1 setObject:answerModel.answerContent forKey:kTestAnswerContent];
            [dic1 setObject:answerModel.answerId forKey:kTestAnserId];
            [array addObject:dic1];
        }
        [dic setObject:questionModel.selectArray forKey:kTestQuestionSelectedAnswers];
        [dic setObject:array forKey:kTestQuestionAnswers];
        
        if (questionModel.isAnsweredCorrect) {
            [rightQuestionArr addObject:dic];
        }else
        {
            [wrongQuestionArr addObject:dic];
            [self.simulateScoreOperation.simulateResultModel addQuestion:questionModel];
        }
        
        if ([questionModel.questionType isEqualToString:@"单选"]) {
            [singleQuestionArr addObject:dic];
        }else if ([questionModel.questionType isEqualToString:@"判断"])
        {
            [judgeQuestionArr addObject:dic];
        }else
        {
            [multipleQuestionArr addObject:dic];
        }
        
    }
    
    [mdic setObject:rightQuestionArr forKey:kRightquistionArr];
    [mdic setObject:wrongQuestionArr forKey:kWrongquistionArr];
    [mdic setObject:singleQuestionArr forKey:kSinglequistionArr];
    [mdic setObject:multipleQuestionArr forKey:kMultiplequistionArr];
    [mdic setObject:judgeQuestionArr forKey:kJudgequistionArr];
    
    return mdic;
}

@end
