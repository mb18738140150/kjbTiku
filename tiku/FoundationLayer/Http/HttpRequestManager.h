//
//  HttpRequestManager.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestProtocol.h"

@interface HttpRequestManager : NSObject

+ (instancetype)sharedManager;

- (void)requestBannerWithDelegate:(__weak id<HttpRequestProtocol>)delegate;


- (void)requestHottestCourseWithProcessDelegate:(__weak id<HttpRequestProtocol>)delegate;


- (void)requestLoginWithUserName:(NSString *)userName
                     andPassword:(NSString *)password
              andProcessDelegate:(__weak id<HttpRequestProtocol>)delegate;

- (void)requestDetailCourseWithCourseID:(int)courseID
                     andProcessDelegate:(__weak id<HttpRequestProtocol>)delegate;

- (void)requestAllCourseWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestQuestionWithPageIndex:(int)pageIndex withProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestQuestionDetailWithQuestionId:(int)questionId withProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestAllCourseCategoryWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestCategoryDetailWithCategoryId:(int)categoryId andUserId:(int)userId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestResetPwdWithOldPassword:(NSString *)oldPwd andNewPwd:(NSString *)newPwd andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestQuestionPublishWithInfo:(NSDictionary *)questionInfo andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestHistoryCourseWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestAddHistoryInfoWithInfo:(NSDictionary *)info;

- (void)requestAllMyNoteWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestAddVideoNoteWithInfo:(NSDictionary *)info andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestDeleteVideoNoteWithId:(int)noteId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestLearingCourseWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestCollectCourseWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestMyQuestionAlreadyReplyWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestMyQuestionNotReplyWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestAddCollectCourseWithCourseId:(int)courseId andProcessDelegate:(id<HttpRequestProtocol>)delegate;
- (void)requestDeleteCollectCourseWithCourseId:(int)courseId andProcessDelegate:(id<HttpRequestProtocol>)delegate;


- (void)requestTestAllCategoryWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestTestChapterInfoWithCateId:(int)cateId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestTestSectionQuestionWithSectionId:(int)sectionId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestTestSimulateInfoWithCateId:(int)cateId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestTestSimulateQuestionWithTestId:(int)testId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestTestSimulateScoreWithInfo:(NSArray *)array andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustAppVersionInfoWithProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestTestErrorInfoWithCateId:(int)cateId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustTestErrorQuesitonWithSectionId:(int)sectionId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqestTestAddMyWrongQuestionWithQuestionId:(int)questionId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestTestMyWrongChapterInfoWithCategoryId:(int)cateId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustTestMyWrongQuestionsWithId:(int)sectionId andProcess:(id<HttpRequestProtocol>)delegate;

- (void)reqeustTestCollectQuestionWithId:(int)questionId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestTestUncollectQuestionWithId:(int)questionId andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)reqeustTestAddQuestionHistoryWithInfo:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

- (void)requestTestAddQuestionDetailHistoryWithInfo:(NSDictionary *)infoDic andProcessDelegate:(id<HttpRequestProtocol>)delegate;

#pragma mark - 未使用
- (void)requestSearchKeyWord:(NSString *)keyWords;
@end
