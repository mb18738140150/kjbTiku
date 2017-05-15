//
//  WriteOperations.m
//  Accountant
//
//  Created by aaa on 2017/3/9.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "WriteOperations.h"
#import "CommonMacro.h"

@implementation WriteOperations

- (BOOL)writeVideoInfo:(NSDictionary *)dic
{
    
    BOOL isSuccess = [self.dataBase executeUpdate:@"insert into Video (videoId,videoName,videoSort,chapterId,path,time) values (?,?,?,?,?,?)",[dic objectForKey:kVideoId],[dic objectForKey:kVideoName],[dic objectForKey:kVideoSort],[dic objectForKey:kChapterId],[dic objectForKey:kVideoPath],[dic objectForKey:kVideoPlayTime]];
    
    return isSuccess;
}

- (BOOL)writeChapterInfo:(NSDictionary *)dic
{
    BOOL isSuccess = [self.dataBase executeUpdate:@"insert into Chapter (chapterId,chapterName,chapterSort,isSingleVideo,courseId,path) values (?,?,?,?,?,?)",[dic objectForKey:kChapterId],[dic objectForKey:kChapterName],[dic objectForKey:kChapterSort],[dic objectForKey:kIsSingleChapter],[dic objectForKey:kCourseID],[dic objectForKey:kChapterPath]];
    
    return isSuccess;
}

- (BOOL)writeCourseInfo:(NSDictionary *)dic
{
    BOOL isSuccess = [self.dataBase executeUpdate:@"INSERT INTO Course (courseId,courseName,courseCoverImage,path) VALUES (?,?,?,?)",[dic objectForKey:kCourseID],[dic objectForKey:kCourseName],[dic objectForKey:kCourseCover],[dic objectForKey:kCoursePath]];
    
    return isSuccess;
}

- (BOOL)writeLineVideoInfo:(NSDictionary *)dic
{
    BOOL isSuccess = [self.dataBase executeUpdate:@"insert into LineVideo (videoId,videoName,path,time) values (?,?,?,?)", [dic objectForKey:kVideoId],[dic objectForKey:kVideoName],[dic objectForKey:kVideoURL],[dic objectForKey:kVideoPlayTime]];
    return isSuccess;
}

- (BOOL)deleteVideoInfo:(NSDictionary *)dic
{
    BOOL isSuccess = NO;
/*    if ([dic objectForKey:kIsSingleChapter]) {
        isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Chapter where chapterId = ?",[dic objectForKey:kVideoId]];
    }else{
        isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Video where videoId = ?",[dic objectForKey:kVideoId]];
    }*/
    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Video where videoId = ?",[dic objectForKey:kVideoId]];
    return isSuccess;
}

- (BOOL)deleteLineVideoInfo:(NSDictionary *)dic
{
    BOOL isSuccess = NO;
    /*    if ([dic objectForKey:kIsSingleChapter]) {
     isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Chapter where chapterId = ?",[dic objectForKey:kVideoId]];
     }else{
     isSuccess = [self.dataBase executeUpdate:@"DELETE FROM Video where videoId = ?",[dic objectForKey:kVideoId]];
     }*/
    isSuccess = [self.dataBase executeUpdate:@"DELETE FROM LineVideo where videoId = ?",[dic objectForKey:kVideoId]];
    return isSuccess;
}

@end
