//
//  ReadOperations.h
//  Accountant
//
//  Created by aaa on 2017/3/9.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface ReadOperations : NSObject

@property (nonatomic,weak)  FMDatabase      *dataBase;

- (BOOL)isCourseSavedWithId:(NSNumber *)courseId;
- (BOOL)isChapterSavedWithId:(NSNumber *)chapterId;
- (BOOL)isVideoSavedWithId:(NSNumber *)videoId;
- (BOOL)isLineVideoSavedWithId:(NSNumber *)videoId;

- (NSArray *)getDownloadCoursesInfos;


- (NSDictionary *)getCourseInfosWithCourseId:(NSNumber *)courseId;

- (NSDictionary *)getLineCourseInfoWithVideoId:(NSNumber *)videoId;

@end
