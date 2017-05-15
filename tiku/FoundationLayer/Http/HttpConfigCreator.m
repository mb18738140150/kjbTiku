//
//  HttpConfigCreator.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "HttpConfigCreator.h"
#import "NSString+MD5.h"
#import "NSDictionary+JsonString.h"
#import "NetMacro.h"
#import "UserManager.h"
#import "CommonMacro.h"
#import "DateUtility.h"

@implementation HttpConfigCreator

+ (HttpConfigModel *)getBannerHttpConfig
{
    HttpConfigModel *bannerHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandBanner};
    [self setConfigModel:bannerHttp withInfo:dic];
    return bannerHttp;
}

+ (HttpConfigModel *)getLoginHttpConfigWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    HttpConfigModel *loginHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandLogin,
                          @"userName":userName,
                          @"password":password};
    [self setConfigModel:loginHttp withInfo:dic];
    return loginHttp;
}

+ (HttpConfigModel *)getSearchConfigWithKeyWord:(NSString *)keyWord
{
    HttpConfigModel *searchHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:@"2",
                          @"keyWord":keyWord,
                          @"userId":@"153"};
    [self setConfigModel:searchHttp withInfo:dic];
    return searchHttp;
}

+ (HttpConfigModel *)getHottestHttpConfig
{
    HttpConfigModel *hotHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandHottestCourse};
    [self setConfigModel:hotHttp withInfo:dic];
    return hotHttp;
}

+ (HttpConfigModel *)getCourseDetailConfigWithCourseID:(int)courseID
{
    HttpConfigModel *detailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandDetailCourse,
                          @"courseId":@(courseID)};
    [self setConfigModel:detailHttp withInfo:dic];
    return detailHttp;
}

+ (HttpConfigModel *)getAllCourseConfig
{
    HttpConfigModel *allCourseHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAllCourse};
    [self setConfigModel:allCourseHttp withInfo:dic];
    return allCourseHttp;
}

+ (HttpConfigModel *)getQuestionConfigWithPageCount:(int)pageCount
{
    HttpConfigModel *wendaHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandQuestion,
                          @"pageId":@(pageCount)};
    [self setConfigModel:wendaHttp withInfo:dic];
    return wendaHttp;
}

+ (HttpConfigModel *)getQuestionDetailConfigWithQuestionId:(int)questionId
{
    HttpConfigModel *detailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandQuestionDetail,
                          @"questionId":@(questionId)};
    [self setConfigModel:detailHttp withInfo:dic];
    return detailHttp;
}

+ (HttpConfigModel *)getAllCategoryConfig
{
    HttpConfigModel *categoryHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAllCategory};
    [self setConfigModel:categoryHttp withInfo:dic];
    return categoryHttp;
}

+ (HttpConfigModel *)getCategoryDetailConfigWithCategoryId:(int)categoryId andUserId:(int)userId
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandCategoryDetail,
                          @"userId":@(userId),
                          @"cateId":@(categoryId)};
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getResetPwdConfigWithOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd
{
    HttpConfigModel *categoryDetailHttp = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandResetPwd,
                          @"newPassword":newPwd,
                          @"oldPassword":oldPwd};
    [self setConfigModel:categoryDetailHttp withInfo:dic];
    return categoryDetailHttp;
}

+ (HttpConfigModel *)getPublishConfigWithInfo:(NSDictionary *)questionInfo
{
    HttpConfigModel *pubModel = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandPublishQuestion,
                          @"classId":[questionInfo objectForKey:kQuestionClassId],
                          @"title":[questionInfo objectForKey:kQuestionTitle],
                          @"contents":[questionInfo objectForKey:kQuestionContent],
                          @"imgStr":[questionInfo objectForKey:kQuestionImgStr]};
    [self setConfigModel:pubModel withInfo:dic];
    return pubModel;
}

+ (HttpConfigModel *)getHistoryConfig
{
    HttpConfigModel *history = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandHistory};
    [self setConfigModel:history withInfo:dic];
    return history;
}

+ (HttpConfigModel *)getAddVideoNoteConfigWithInfo:(NSDictionary *)info
{
    HttpConfigModel *add = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAddVideoNote,
                          @"courseId":[info objectForKey:kCourseID],
                          @"chapterId":[info objectForKey:kChapterId],
                          @"videoId":[info objectForKey:kVideoId],
                          @"contents":[info objectForKey:kNoteVideoNoteContent]};
    [self setConfigModel:add withInfo:dic];
    return add;
}

+ (HttpConfigModel *)getDeleteVideoNoteConfigWithId:(int)noteId
{
    HttpConfigModel *delete = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandDeleteVideoNote,
                          @"id":@(noteId)};
    [self setConfigModel:delete withInfo:dic];
    return delete;
}

+ (HttpConfigModel *)getLearningConfig
{
    HttpConfigModel *learning = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandLearningCourse};
    [self setConfigModel:learning withInfo:dic];
    return learning;
}

+ (HttpConfigModel *)getMyQuestionAlreadyReplyConfig
{
    HttpConfigModel *reply = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyQuestion,
                          @"type":@"1"};
    [self setConfigModel:reply withInfo:dic];
    return reply;
}

+ (HttpConfigModel *)getMyQuestionNotReplyConfig
{
    HttpConfigModel *not = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandMyQuestion,
                          @"type":@"0"};
    [self setConfigModel:not withInfo:dic];
    return not;
}

+ (HttpConfigModel *)getCollectConfig
{
    HttpConfigModel *collect = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandCollectCourse};
    [self setConfigModel:collect withInfo:dic];
    return collect;
}

+ (HttpConfigModel *)getAllMyNoteConfig
{
    HttpConfigModel *note = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAllMyNote};
    [self setConfigModel:note withInfo:dic];
    return note;
}

+ (HttpConfigModel *)getAddHistoryConfigWithInfo:(NSDictionary *)info
{
    HttpConfigModel *add = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAddHistory,
                          @"courseId":[info objectForKey:kCourseID],
                          @"chapterId":[info objectForKey:kChapterId],
                          @"videoId":[info objectForKey:kVideoId]};
    [self setConfigModel:add withInfo:dic];
    return add;
}

+ (HttpConfigModel *)getAddCollectCourseConfigWithCourseId:(int)courseId
{
    HttpConfigModel *add = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAddCollectCourse,
                          @"id":@(courseId)};
    [self setConfigModel:add withInfo:dic];
    return add;
}

+ (HttpConfigModel *)getDeleteCollectCourseConfigWithCourseId:(int)courseId
{
    HttpConfigModel *delete = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandDeleteCollectCourse,
                          @"id":@(courseId)};
    [self setConfigModel:delete withInfo:dic];
    return delete;
}

+ (HttpConfigModel *)getTestAllCategoryConfig
{
    HttpConfigModel *cate = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestCategory};
    [self setKJBConfigModel:cate withInfo:dic];
    return cate;
}

+ (HttpConfigModel *)getTestChapterInfoWithId:(int)cateId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestChapterInfo,
                          @"id":@(cateId)};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestSectionInfoWithId:(int)sectionId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestSectionQuestion,
                          @"id":@(sectionId),
                          @"type":@"chapters",
                          @"category":@(2)};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestSimulateInfoWithId:(int)cateId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestSimulateInfo,
                          @"id":@(cateId)};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestSimulateQuestionWithId:(int)testId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestSimulateQuestion,
                          @"id":@(testId),
                          @"type":@"newsimus",
                          @"category":@(2)};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestSimulateScoreWithInfo:(NSArray *)array
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestSimulateScore,
                          @"answers":array};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getAppVersionInfoConfig
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandVersionInfo,
                          @"type":@(2)};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestErrorInfoWithId:(int)cateId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestErrorInfo,
                          @"id":@(cateId),
                          @"type":@"easywrong",
                          @"category":@(2)};
    [self setKJBConfigModel:c withInfo:dic];
    return c;

}

+ (HttpConfigModel *)getTestErrorQuestionWithSectionId:(int)sectionId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestErrorQuestion,
                          @"id":@(sectionId),
                          @"type":@"easywrong",
                          @"category":@(2)};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestAddMyWrongQuestionWithQuestionId:(int)questionId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandAddMyWrongQuestion,
                          @"id":@[@(questionId)],
                          @"contents":@"1",
                          @"type":@"wrongbook"};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestMyWrongChapterListWithCategoryId:(int)cateId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestMyWrongChapter,
                          @"id":@(cateId),
                          @"type":@"wrongbook",
                          @"category":@(2)};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestMyWrongQuestionWithId:(int)sectionId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestMyWrongQuestion,
                          @"id":@(sectionId),
                          @"type":@"wrongbook",
                          @"category":@(2)};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestCollectQuestionWithQuestionId:(int)questionId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestCollectQuestion,
                          @"id":@[@(questionId)],
                          @"contents":@"1",
                          @"type":@"bookmarks"};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestUncollectQuestionWithQuestionId:(int)questionId
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestUncollectQuestion,
                          @"id":@[@(questionId)],
                          @"contents":@"1",
                          @"type":@"bookmarks"};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestHistoryConfigWithInfo:(NSDictionary *)infoDic
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestAddHistory,
                          @"testType":[infoDic objectForKey:kTestAddHistoryType],
                          @"chapterId":[infoDic objectForKey:kTestChapterId],
                          @"unitId":[infoDic objectForKey:kTestSectionId],
                          @"simuId":[infoDic objectForKey:kTestSimulateId],
                          @"beginTime":[DateUtility getCurrentDateString],
                          @"endTime":[DateUtility getCurrentDateString]};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

+ (HttpConfigModel *)getTestHistoryDetailConfigWithInfo:(NSDictionary *)infoDic
{
    HttpConfigModel *c = [[HttpConfigModel alloc] init];
    NSDictionary *dic = @{kCommand:kCommandTestAddHistoryDetail,
                          @"logId":[infoDic objectForKey:kTestAddDetailHistoryLogId],
                          @"testId":[infoDic objectForKey:kTestQuestionId],
                          @"answer":[infoDic objectForKey:kTestAnserId],
                          @"resultCode":@([[infoDic objectForKey:kTestQuestionResult] intValue])};
    [self setKJBConfigModel:c withInfo:dic];
    return c;
}

#pragma mark - utility
+ (void)setConfigModel:(HttpConfigModel *)configModel withInfo:(NSDictionary *)parameters
{
    if ([[UserManager sharedManager] isUserLogin]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [dic setObject:@([[UserManager sharedManager] getUserId]) forKey:@"userId"];
        configModel.parameters = dic;
    }else{
        configModel.parameters = parameters;
    }
    
    
    NSString *str = [NSString stringWithFormat:@"%@%@",[configModel.parameters jsonString],kMD5String];
    configModel.urlString = [NSString stringWithFormat:@"%@?md5=%@",kRootUrl,[str MD5]];
    int command = [[parameters objectForKey:@"command"] intValue];
    configModel.command = @(command);
}

+ (void)setKJBConfigModel:(HttpConfigModel *)configModel withInfo:(NSDictionary *)parameters
{
    if ([[UserManager sharedManager] isUserLogin]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [dic setObject:@([[UserManager sharedManager] getUserId]) forKey:@"userId"];
        configModel.parameters = dic;
    }else{
        configModel.parameters = parameters;
    }
    
    
    NSString *str = [NSString stringWithFormat:@"%@%@",[configModel.parameters jsonString],kMD5String];
    configModel.urlString = [NSString stringWithFormat:@"%@?md5=%@",kRootKJBUrl,[str MD5]];
    int command = [[parameters objectForKey:@"command"] intValue];
    configModel.command = @(command);
}



@end
