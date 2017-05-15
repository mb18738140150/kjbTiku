//
//  ReadOperations.m
//  Accountant
//
//  Created by aaa on 2017/3/9.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "ReadOperations.h"
#import "CommonMacro.h"

@implementation ReadOperations

- (BOOL)isCourseSavedWithId:(NSNumber *)courseId
{
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Course WHERE courseId = ?",courseId];
    while ([s next]) {
        return YES;
    }
    return NO;
}

- (BOOL)isChapterSavedWithId:(NSNumber *)chapterId
{
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Chapter WHERE chapterId = ?",chapterId];
    while ([s next]) {
        return YES;
    }
    return NO;
}

- (BOOL)isVideoSavedWithId:(NSNumber *)videoId
{
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Video WHERE videoId = ?",videoId];
    while ([s next]) {
        return YES;
    }
    return NO;
}

- (BOOL)isLineVideoSavedWithId:(NSNumber *)videoId
{
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM LineVideo WHERE videoId = ?", videoId];
    while ([s next]) {
        return YES;
    }
    return NO;
}

- (NSDictionary *)getCourseInfosWithCourseId:(NSNumber *)courseId
{
    NSMutableDictionary *courseInfo = [[NSMutableDictionary alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Course WHERE courseId = ?",courseId];
    while ([s next]) {
        [courseInfo setObject:[s stringForColumn:@"courseName"] forKey:kCourseName];
        [courseInfo setObject:@([s intForColumn:@"courseId"]) forKey:kCourseID];
        
        NSArray *chapters = [self getChapterInfosWithCourseId:@([s intForColumn:@"courseId"])];
        
        [courseInfo setObject:chapters forKey:kCourseChapterInfos];
        
        [courseInfo setObject:[s stringForColumn:@"courseCoverImage"] forKey:kCourseCover];
        [courseInfo setObject:[s stringForColumn:@"path"] forKey:kCoursePath];
    }
    return courseInfo;
}

- (NSDictionary *)getLineCourseInfoWithVideoId:(NSNumber *)videoId
{
    NSMutableDictionary *videoInfo = [[NSMutableDictionary alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM LineVideo WHERE videoId = ?",videoId];
    while ([s next]) {
        [videoInfo setValue:@([s intForColumn:@"videoId"]) forKey:kVideoId];
        [videoInfo setValue:[s stringForColumn:@"path"] forKey:kVideoURL];
        [videoInfo setValue:[s stringForColumn:@"videoName"] forKey:kVideoName];
        [videoInfo setValue:@([s intForColumn:@"time"]) forKey:kVideoPlayTime];
    }
    return videoInfo;
}

- (NSArray *)getDownloadCoursesInfos
{
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Course"];
    while ([s next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[s stringForColumn:@"courseName"] forKey:kCourseName];
        [dic setObject:@([s intForColumn:@"courseId"]) forKey:kCourseID];
        
        NSArray *chapters = [self getChapterInfosWithCourseId:@([s intForColumn:@"courseId"])];
        
        [dic setObject:chapters forKey:kCourseChapterInfos];
        
        [dic setObject:[s stringForColumn:@"courseCoverImage"] forKey:kCourseCover];
        [dic setObject:[s stringForColumn:@"path"] forKey:kCoursePath];
        [arry addObject:dic];
    }
    return arry;
}

- (NSArray *)getChapterInfosWithCourseId:(NSNumber *)courseId
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Chapter WHERE courseId = ? ORDER BY chapterSort",courseId];
    while ([s next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@([s intForColumn:@"chapterId"]) forKey:kChapterId];
        [dic setObject:[s stringForColumn:@"chapterName"] forKey:kChapterName];
        [dic setObject:@([s intForColumn:@"chapterSort"]) forKey:kChapterSort];
        [dic setObject:@([s intForColumn:@"isSingleVideo"]) forKey:kIsSingleChapter];
        [dic setObject:[s stringForColumn:@"path"] forKey:kChapterPath];
        
        if ([s intForColumn:@"isSingleVideo"] != 1) {
            NSArray *videos = [self getVideoInfosWithChapterId:@([s intForColumn:@"chapterId"])];
            [dic setObject:videos forKey:kChapterVideoInfos];
        }else{
            NSArray *videos = @[@{kVideoId:@([s intForColumn:@"chapterId"]),
                                  kVideoName:[s stringForColumn:@"chapterName"],
                                  kVideoSort:@(1)}];
            [dic setObject:videos forKey:kChapterVideoInfos];
        }
        [array addObject:dic];
        
    }
    
    return array;
}

- (NSArray *)getVideoInfosWithChapterId:(NSNumber *)chapterId
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    FMResultSet *s = [self.dataBase executeQuery:@"SELECT * FROM Video WHERE chapterId = ? ORDER BY videoSort",chapterId];
    while ([s next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@([s intForColumn:@"videoId"]) forKey:kVideoId];
        [dic setObject:[s stringForColumn:@"videoName"] forKey:kVideoName];
        [dic setObject:@([s intForColumn:@"videoSort"]) forKey:kVideoSort];
        [dic setObject:[s stringForColumn:@"path"] forKey:kVideoPath];
        [dic setObject:@([s intForColumn:@"time"]) forKey:kVideoPlayTime];
        
        [array addObject:dic];
    }
    return array;
}

@end
