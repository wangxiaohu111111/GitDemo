//
//  BaseDatabaseHelper.m
//  STSO2O
//
//  Created by wangxiaohu on 13-10-29.
//  Copyright (c) 2013年 stswxh. All rights reserved.
//


#import "BaseDatabaseHelper.h"
#import "My_Utils.h"
#import <objc/runtime.h>

#import "PlistDataUtils.h"


@implementation BaseDatabaseHelper

-(id)init{
    id mySelf=[super init];
    if (mySelf) {
    }
    return mySelf;
}

- (void)createTables:(id)entity{
    //创建表的sql//create table shop_type(id integer primary key autoincrement,shop_type_id nvarchar(30),show_type_name nvarchar(64)
    NSMutableString *sqlString=[[NSMutableString alloc] init];
    Class className=[entity class];
    [sqlString appendString:[NSString stringWithFormat:@"create table %@ (idCel integer primary key autoincrement, ",className]];
    unsigned int propertyCount;
    objc_property_t *propertys=class_copyPropertyList(className, &propertyCount);
    for (int i=0; i<propertyCount; i++) {
        objc_property_t property=propertys[i];
        NSString *propertyName=[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *propertyType=[self getPropertyType:property];
        id propertyValue=[entity valueForKey:propertyName];
        if ([@"i" isEqualToString:propertyType]) {
            [sqlString appendString:[NSString stringWithFormat:@"%@ integer,",propertyName ]];
        }else if([@"d" isEqualToString:propertyType]){
            [sqlString appendString:[NSString stringWithFormat:@"%@ double,",propertyName]];
        }else if([@"f" isEqualToString:propertyType]){
            [sqlString appendString:[NSString stringWithFormat:@"%@ float,",propertyName]];
        }else if([@"NSString" isEqualToString:propertyType]){
            [sqlString appendString:[NSString stringWithFormat:@"%@ nvarchar(300),",propertyName]];
        }else if([@"NSDate" isEqualToString:propertyType]){
            [sqlString appendString:[NSString stringWithFormat:@"%@ date,",propertyName]];
        }
        NSLog(@"propertyType=%@,propertyValue=%@",propertyType,propertyValue);
    }
    NSString *sqlx=[sqlString substringWithRange:NSMakeRange(0,[sqlString length]-1)];
    
    NSMutableString *sql=[[NSMutableString alloc] init];
    [sql appendString:[NSString stringWithFormat:@"%@)",sqlx]];
    [self execSql:sql];
    NSLog(@"sql=%@",sql);
}

-(NSString *)getPropertyType:(objc_property_t)property{
    
    NSArray *type=[[[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding] componentsSeparatedByString:@","];
    
    NSString *propertyType=[[[type objectAtIndex:0] stringByReplacingOccurrencesOfString:@"T" withString:@""]stringByReplacingOccurrencesOfString:@"@" withString:@""];
    if ([propertyType length]>1) {
        propertyType=[propertyType substringWithRange:NSMakeRange(1,propertyType.length-2)];
    }
    
    return propertyType;
}



-(BOOL) insertVOIntoDB:(id)entity{
    BOOL flag=false;
    NSMutableString *inserSql=[[NSMutableString alloc] init];
    
    Class className=[entity class];
    
    NSMutableString *cols=[[NSMutableString alloc] init];
    NSMutableString *values=[[NSMutableString alloc] init];
    
    unsigned int propertyCount;
    objc_property_t *propertys=class_copyPropertyList(className, &propertyCount);
    for (int i=0; i<propertyCount; i++) {
        objc_property_t property=propertys[i];
        NSString *propertyName=[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        NSString *propertyType=[self getPropertyType:property];
        
        id propertyValue=[entity valueForKey:propertyName];
        
        if (nil==propertyValue) {
            continue;
        }
        
        if ([@"i" isEqualToString:propertyType]) {
            [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
            [values appendString:[NSString stringWithFormat:@"%d,",[propertyValue intValue]]];
            
        }else if([@"d" isEqualToString:propertyType]){
            [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
            [values appendString:[NSString stringWithFormat:@"%f,",[propertyValue floatValue]]];
        }else if([@"f" isEqualToString:propertyType]){
            [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
            [values appendString:[NSString stringWithFormat:@"%f,",[propertyValue doubleValue]]];
        }else if([@"NSString" isEqualToString:propertyType]){
            [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
            [values appendString:[NSString stringWithFormat:@"'%@',",propertyValue]];
        }else if([@"NSDate" isEqualToString:propertyType]){
            [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
            [values appendString:[NSString stringWithFormat:@"'%@',",propertyValue]];
        }
    }
    
    NSString *col= [cols substringWithRange:NSMakeRange(0,[cols length]-1)];
    NSString *val= [values substringWithRange:NSMakeRange(0,[values length]-1)];
    
    [inserSql appendString:[NSString stringWithFormat:@"insert into %@ (%@) values (%@)",className,col,val]];
    flag=[self execSql:inserSql];
    return flag;
}

-(void) insertAllVOIntoDB:(NSMutableArray *) allVOs{
    
    NSMutableArray *sqls=[[NSMutableArray alloc] init];
    
    for (id entity in allVOs) {
        NSMutableString *inserSql=[[NSMutableString alloc] init];
        
        Class className=[entity class];
        
        NSMutableString *cols=[[NSMutableString alloc] init];
        NSMutableString *values=[[NSMutableString alloc] init];
        
        unsigned int propertyCount;
        objc_property_t *propertys=class_copyPropertyList(className, &propertyCount);
        for (int i=0; i<propertyCount; i++) {
            objc_property_t property=propertys[i];
            NSString *propertyName=[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            
            NSString *propertyType=[self getPropertyType:property];
            
            id propertyValue=[entity valueForKey:propertyName];
            
            if (nil==propertyValue) {
                continue;
            }
            
            if ([@"i" isEqualToString:propertyType]) {
                [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
                [values appendString:[NSString stringWithFormat:@"%d,",[propertyValue intValue]]];
                
            }else if([@"d" isEqualToString:propertyType]){
                [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
                [values appendString:[NSString stringWithFormat:@"%f,",[propertyValue floatValue]]];
            }else if([@"f" isEqualToString:propertyType]){
                [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
                [values appendString:[NSString stringWithFormat:@"%f,",[propertyValue doubleValue]]];
            }else if([@"NSString" isEqualToString:propertyType]){
                [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
                [values appendString:[NSString stringWithFormat:@"'%@',",propertyValue]];
            }else if([@"NSDate" isEqualToString:propertyType]){
                [cols appendString:[NSString stringWithFormat:@"%@,",propertyName]];
                [values appendString:[NSString stringWithFormat:@"'%@',",propertyValue]];
            }
        }
        
        NSString *col= [cols substringWithRange:NSMakeRange(0,[cols length]-1)];
        NSString *val= [values substringWithRange:NSMakeRange(0,[values length]-1)];
        
        [inserSql appendString:[NSString stringWithFormat:@"insert into %@ (%@) values (%@)",className,col,val]];
        [sqls addObject:inserSql];
    }
    
    [self execInsertTransactionSql:sqls];
}

-(BOOL) deleteVOFromDB:(id)entity{
    BOOL flag=false;
    NSString *deleteSql=@"";
    
    flag=[self execSql:deleteSql];
    return flag;
}

-(BOOL) updateVOIntoDB:(id)entity withKey:(NSString *)key andValue:(NSString *)value{
    BOOL flag=false;
    
    NSMutableString *updateSql=[[NSMutableString alloc] init];
    Class className=[entity class];
    [updateSql appendString:[NSString stringWithFormat:@"update %@ set ",className]];
    
    unsigned int propertyCount;
    objc_property_t *propertys=class_copyPropertyList(className, &propertyCount);
    for (int i=0; i<propertyCount; i++) {
        objc_property_t property=propertys[i];
        NSString *propertyName=[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        NSString *propertyType=[self getPropertyType:property];
        
        id propertyValue=[entity valueForKey:propertyName];
        
        if (nil==propertyValue) {
            continue;
        }
        
        if ([@"i" isEqualToString:propertyType]) {
            [updateSql appendString:[NSString stringWithFormat:@"%@=%d,",propertyName,[propertyValue intValue]]];
        }else if([@"d" isEqualToString:propertyType]){
            [updateSql appendString:[NSString stringWithFormat:@"%@=%f,",propertyName,[propertyValue doubleValue]]];
        }else if([@"f" isEqualToString:propertyType]){
            [updateSql appendString:[NSString stringWithFormat:@"%@=%f,",propertyName,[propertyValue floatValue]]];
        }else if([@"NSString" isEqualToString:propertyType]){
            [updateSql appendString:[NSString stringWithFormat:@"%@='%@',",propertyName,propertyValue]];
        }else if([@"NSDate" isEqualToString:propertyType]){
            [updateSql appendString:[NSString stringWithFormat:@"%@='%@',",propertyName,propertyValue]];
        }
    }
    
    NSString *sqlx=[updateSql substringWithRange:NSMakeRange(0,[updateSql length]-1)];
    
    NSMutableString *sql=[[NSMutableString alloc] init];
    [sql appendString:[NSString stringWithFormat:@"%@ where %@='%@'",sqlx,key,value]];
    
    flag=[self execSql:sql];
    return flag;
}

-(id)getEntityFromDB:(NSString *)sql withClass:(Class)myClass returnCount:(int) count{
    NSMutableArray *dataAll=[[NSMutableArray alloc]init];
    @synchronized(self){
        BOOL flag=[self openDataBase];
        if (flag) {
            const char *selectSql=[My_Utils stringToChar:sql];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(db, selectSql, -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    id obj=[[myClass alloc] init];
                    for (int i=0; i<count; i++) {
                        NSString *fileValues=[My_Utils charToNSString:(char *)sqlite3_column_text(statement, i)];
                        NSString *columnName=[[NSString alloc] initWithCString:sqlite3_column_name(statement, i) encoding:NSUTF8StringEncoding];
                        [obj setValue:fileValues forKey:columnName];
                    }
                    [dataAll addObject:obj];
                }
            }else{
                NSLog(@"select fail=%@",sql);
            }
            sqlite3_finalize(statement);
            sqlite3_close(db);
        }
    }
    return dataAll;
}

-(NSMutableArray *)getVOFromDB:(NSString *)sql returnCount:(int)count{
    NSMutableArray *dataAll=[[NSMutableArray alloc]init];
    @synchronized(self){
        BOOL flag=[self openDataBase];
        if (flag) {
            const char *selectSql=[My_Utils stringToChar:sql];
            sqlite3_stmt *statement;
            if (sqlite3_prepare_v2(db, selectSql, -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    NSMutableArray *data=[[NSMutableArray alloc]init];
                    for (int i=0; i<count; i++) {
                        NSString *fileValues=[My_Utils charToNSString:(char *)sqlite3_column_text(statement, i)];
                        [data addObject:fileValues];
                    }
                    [dataAll addObject:data];
                }
            }else{
                NSLog(@"select fail=%@",sql);
            }
            sqlite3_finalize(statement);
            sqlite3_close(db);
        }
    }
    
    return dataAll;
}

-(BOOL)execSql:(NSString *)sql
{
    Boolean flag=false;
    @synchronized(self){
        if ([self openDataBase]) {
            char *err;
            if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
                NSLog(@"crud fail=%@",[My_Utils charToNSString:err]);
                flag=false;
            }else{
                NSLog(@"sql=%@",sql);
                flag=true;
            }
            sqlite3_close(db);
        }
    }
    return flag;
}

//执行插入事务语句
-(void)execInsertTransactionSql:(NSMutableArray *)transactionSql{
    @synchronized(self){
        //使用事务，提交插入sql语句
        sqlite3_stmt *statement;
        @try{
            if ([self openDataBase]) {
                char *errorMsg;
                if (sqlite3_exec(db, "BEGIN", NULL, NULL, &errorMsg)==SQLITE_OK){
                    NSLog(@"启动事务成功");
                    for (int i = 0; i<transactionSql.count; i++){
                        if (sqlite3_prepare_v2(db,[[transactionSql objectAtIndex:i] UTF8String], -1, &statement,NULL)==SQLITE_OK){
                            if (sqlite3_step(statement)!=SQLITE_DONE) sqlite3_finalize(statement);
                        }
                    }
                    if (sqlite3_exec(db, "COMMIT", NULL, NULL, &errorMsg)==SQLITE_OK)   NSLog(@"提交事务成功");
                }else{
                }
            }
        }@catch(NSException *e){
            char *errorMsg;
            if (sqlite3_exec(db, "ROLLBACK", NULL, NULL, &errorMsg)==SQLITE_OK){
                NSLog(@"回滚事务成功");
            }
        }@finally{
            sqlite3_close(db);
        }
    }
}

-(BOOL) openDataBase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:databaseName];
    if (sqlite3_open([database_path UTF8String], &db) == SQLITE_OK) {
        return YES;
    }else{
        sqlite3_close(db);
        return NO;
    }
}

-(BOOL)dataBaseFileIsExit{

    NSDictionary *dic1=[PlistDataUtils getAllNSDictionary];
    
    if ([isExit isEqualToString:[dic1 objectForKey:DataBaseIsExit]]) {
        return true;
    }else{
        NSMutableDictionary * newDic=[NSMutableDictionary dictionaryWithDictionary:dic1];
        [newDic setObject:isExit forKey:DataBaseIsExit];
        [PlistDataUtils setKeyWithValue:newDic];
        return false;
    }
}


@end
