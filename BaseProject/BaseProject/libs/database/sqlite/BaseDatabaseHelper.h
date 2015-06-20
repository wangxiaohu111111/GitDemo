//
//  BaseDatabaseHelper.h
//  STSO2O
//
//  Created by wangxiaohu on 13-10-29.
//  Copyright (c) 2013年 stswxh. All rights reserved.
//

#define isExit @"YES"
#define DataBaseIsExit @"DataBaseIsExit"

#define  databaseName @"CoreDataStore.sqlite"

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BaseDatabaseHelper : NSObject{
    sqlite3 *db;
}

- (void)createTables:(id)entity;

- (BOOL)execSql:(NSString *)sql;

- (BOOL) insertVOIntoDB:(id)entity;

-(void) insertAllVOIntoDB:(NSMutableArray *) allVOs;

-(BOOL) updateVOIntoDB:(id)entity withKey:(NSString *)key andValue:(NSString *)value;

- (id)getEntityFromDB:(NSString *)sql withClass:(Class)myClass returnCount:(int) count;

- (NSMutableArray *)getVOFromDB:(NSString *)sql returnCount:(int)count;

-(BOOL)dataBaseFileIsExit;

@end
