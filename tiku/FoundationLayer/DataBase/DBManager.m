//
//  DBManager.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "DBManager.h"
#import "PathUtility.h"
#import "FMDB.h"
#import "ReadOperations.h"
#import "WriteOperations.h"
#import "CommonMacro.h"

@interface DBManager ()

@property (nonatomic,strong) FMDatabase         *dataBase;

@property (nonatomic,strong) ReadOperations     *readOperation;
@property (nonatomic,strong) WriteOperations    *writeOperation;

@end

@implementation DBManager

+ (instancetype)sharedManager
{
    static DBManager *__manager__;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager__ = [[DBManager alloc] init];
    });
    return __manager__;
}

- (void)intialDB
{
    NSString *DBPath = [[PathUtility getDocumentPath] stringByAppendingPathComponent:@"1.db"];
    self.dataBase = [FMDatabase databaseWithPath:DBPath];
    if (![self.dataBase open]) {
        NSLog(@"数据库打开错误");
        return;
    }
    [self initalTables];
    self.readOperation = [[ReadOperations alloc] init];
    self.readOperation.dataBase = self.dataBase;
    self.writeOperation = [[WriteOperations alloc] init];
    self.writeOperation.dataBase = self.dataBase;
}

- (void)initalTables
{
    NSString *initalTablesSql = @"CREATE TABLE IF NOT EXISTS Course (courseName text(128) NOT NULL,courseId integer(32) PRIMARY KEY NOT NULL,courseCoverImage text(128) NOT NULL,path text(32) NOT NULL);"
                                "CREATE TABLE IF NOT EXISTS Chapter (chapterId integer(32) PRIMARY KEY NOT NULL,chapterName text(128) NOT NULL,chapterSort integer(32) NOT NULL,courseId integer(32) NOT NULL,isSingleVideo integer(1) NOT NULL,path text(32) NOT NULL);"
                                "CREATE TABLE IF NOT EXISTS Video (videoId integer(32) PRIMARY KEY NOT NULL,videoName text(128) NOT NULL,videoSort integer(32) NOT NULL,chapterId integer(32) NOT NULL,path text(32) NOT NULL,time intrger(32) NOT NULL);"
                                "CREATE TABLE IF NOT EXISTS LineVideo (videoId integer(32) PRIMARY KEY NOT NULL,videoName text(128) NOT NULL,path text(32) NOT NULL,time intrger(32) NOT NULL);";
    BOOL isCreate = [self.dataBase executeStatements:initalTablesSql];
    if (!isCreate) {
    }
}

- (NSArray *)getDownloadedCourseInfo
{
    return [self.readOperation getDownloadCoursesInfos];
}

- (NSDictionary *)getCourseInfosWithCourseId:(NSNumber *)courseId
{
    return [self.readOperation getCourseInfosWithCourseId:courseId];
}

- (NSDictionary *)getLineVideoInfoWithVideoId:(NSNumber *)videoId
{
    return [self.readOperation getLineCourseInfoWithVideoId:videoId];
}

- (void)deleteVideos:(NSDictionary *)videoInfo
{
    [self.writeOperation deleteVideoInfo:videoInfo];
}

#pragma mark - save
- (void)saveDownloadInfo:(NSDictionary *)infoDic
{
/*    int courseId = [[infoDic objectForKey:kCourseID] intValue];
    NSString *courseName = [infoDic objectForKey:kCourseName];
    NSString *coursePath = [infoDic objectForKey:kCoursePath];
    
    int chapterId = [[infoDic objectForKey:kChapterId] intValue];
    NSString *chapterName = [infoDic objectForKey:kChapterName];
    int chapterSort = [[infoDic objectForKey:kChapterSort] intValue];
    NSString *chapterPath = [infoDic objectForKey:kChapterPath];
    
    int videoId = [[infoDic objectForKey:kVideoId] intValue];
    NSString *videoName = [infoDic objectForKey:kVideoName];
    int videoSort = [[infoDic objectForKey:kVideoSort] intValue];
    NSString *videoPath = [infoDic objectForKey:kVideoPath];*/
    
    if (![self.readOperation isCourseSavedWithId:[infoDic objectForKey:kCourseID]]) {
        [self.writeOperation writeCourseInfo:infoDic];
    }
    if (![self.readOperation isChapterSavedWithId:[infoDic objectForKey:kChapterId]]) {
        [self.writeOperation writeChapterInfo:infoDic];
    }
    if (![self.readOperation isVideoSavedWithId:[infoDic objectForKey:kVideoId]]) {
        [self.writeOperation writeVideoInfo:infoDic];
    }else
    {
        if ([self.writeOperation deleteVideoInfo:infoDic]) {
            [self.writeOperation writeVideoInfo:infoDic];
        }
    }
    
    
}

- (void)saveLineVideoInfo:(NSDictionary *)infoDic
{
    if (![self.readOperation isLineVideoSavedWithId:[infoDic objectForKey:kVideoId]]) {
        [self.writeOperation writeLineVideoInfo:infoDic];
    }else
    {
        if ([self.writeOperation deleteLineVideoInfo:infoDic]) {
            [self.writeOperation writeLineVideoInfo:infoDic];
        }
    }
}

- (BOOL)isVideoDownload:(NSNumber *)videoId
{
    return [self.readOperation isVideoSavedWithId:videoId];
}

@end
