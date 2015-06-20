//
//  CoreDataHelper.h
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-25.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//


/**
 
 
 //
 //    Dept * dept= [Dept MR_createEntity];
 //    dept.id=[[NSNumber alloc] initWithInt:10005];
 //    dept.deptname=@"MRDept";
 //
 //    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
 //        if (success) {
 //            NSLog(@"success");
 //        }else{
 //            NSLog(@"fail msg=%@",[error description]);
 //        }
 //    }];
 
 //
 //    Dept * dept= [Dept createEntity];
 //    dept.id=[[NSNumber alloc] initWithInt:10006];
 //    dept.deptname=@"WXHDept";
 //    [dept addEntity];
 
 //
 //    NSArray * depts=[Dept MR_findAll];
 //    for (Dept * deptx in depts) {
 //        NSLog(@"id=%lu,name=%@",[deptx.id longValue],deptx.deptname);
 //    }
 //    NSLog(@"--------------");
 //    NSArray * deptsq=[Dept searchDataInDatabaseWithPredicate:nil withNSSortDescriptors:nil];
 //    for (Dept * deptx in deptsq) {
 //        NSLog(@"id=%lu,name=%@",[deptx.id longValue],deptx.deptname);
 //    }
 //
 //    NSString * sql=@"SELECT t0.Z_PK, t0.Z_OPT, t0.ZDEPTNAME, t0.ZID FROM ZDEPT t0";
 //    NSMutableArray * arrays=[[[BaseDatabaseHelper alloc] init] getVOFromDB:sql returnCount:4];
 //    for (NSMutableArray * cloms in arrays) {
 //        for (NSMutableArray * clom in cloms) {
 //            NSLog(@"clom=%@",clom);
 //        }
 //        NSLog(@"------");
 //    }
 
 **/

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define ModelNamed @"CoreDataModel"
#define SQLNamed @"CoreDataStore.sqlite"


typedef void(^ComplateHandle)(BOOL success,NSError * error);

@interface CoreDataHelper : NSObject

+(id)newInstances;

+(void)clearnUp;

@end


@interface NSManagedObject (EntityObject)

+(id)createEntity;

-(BOOL)addEntity;
-(BOOL)updateEntity;
-(BOOL)deleteEntity;
+(NSArray *)searchDataInDatabaseWithPredicate:(NSPredicate *) predicate withNSSortDescriptors:(NSArray *)sortDescriptors;

@end
