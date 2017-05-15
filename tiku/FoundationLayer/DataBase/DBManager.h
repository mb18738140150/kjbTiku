//
//  DBManager.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

+ (instancetype)sharedManager;

- (void)intialDB;

- (void)saveDownloadInfo:(NSDictionary *)infoDic;

- (void)saveLineVideoInfo:(NSDictionary *)infoDic;

- (BOOL)isVideoDownload:(NSNumber *)videoId;

- (NSArray *)getDownloadedCourseInfo;

- (NSDictionary *)getCourseInfosWithCourseId:(NSNumber *)courseId;

- (NSDictionary *)getLineVideoInfoWithVideoId:(NSNumber *)videoId;

- (void)deleteVideos:(NSDictionary *)videoInfo;

@end
