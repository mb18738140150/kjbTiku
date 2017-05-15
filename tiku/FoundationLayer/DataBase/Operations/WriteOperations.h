//
//  WriteOperations.h
//  Accountant
//
//  Created by aaa on 2017/3/9.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface WriteOperations : NSObject

@property (nonatomic,weak)  FMDatabase      *dataBase;

- (BOOL)writeVideoInfo:(NSDictionary *)dic;

- (BOOL)writeChapterInfo:(NSDictionary *)dic;

- (BOOL)writeCourseInfo:(NSDictionary *)dic;

- (BOOL)deleteVideoInfo:(NSDictionary *)dic;

- (BOOL)writeLineVideoInfo:(NSDictionary *)dic;

- (BOOL)deleteLineVideoInfo:(NSDictionary *)dic;

@end
