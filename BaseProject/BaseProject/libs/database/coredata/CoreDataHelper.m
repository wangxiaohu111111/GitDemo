//
//  CoreDataHelper.m
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-25.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "CoreDataHelper.h"

static CoreDataHelper * coreDataHelper;
static NSManagedObjectContext * context;

@interface CoreDataHelper(){

}

@end


@implementation CoreDataHelper


+(id)newInstances{

    if (coreDataHelper==nil) {
        coreDataHelper=[[CoreDataHelper alloc] init];
    }
    return coreDataHelper;
}

+(void)clearnUp{
    coreDataHelper=nil;
}

-(instancetype)init{

    self=[super init];
    if (self) {
        [self createCoreData];
    }
    return self;
}

+(NSManagedObjectContext *)getContext{
    
    return context;
}

-(void)createCoreData{
    // 从应用程序包中加载模型文件
    NSManagedObjectModel *model = [[ NSManagedObjectModel alloc] initWithContentsOfURL:[[ NSBundle mainBundle] URLForResource:ModelNamed withExtension:@"momd"]];
    // 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 构建SQLite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:SQLNamed]];
    // 添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    // 初始化上下文，设置persistentStoreCoordinator属性
    context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = psc;
    // 用完之后，记得要[context release];
    
}


+(NSArray *)searchDataInDatabase:(NSString *)entityName withPredicate:(NSPredicate *) predicate withNSSortDescriptors:(NSArray *)sortDescriptors{
    // 初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    // 设置排序（按照age降序）
    // NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = sortDescriptors;
    // 设置条件过滤(搜索name中包含字符串"Itcast-1"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*Itcast-1*)
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", @"*Itcast-1*"];
    request.predicate = predicate;
    // 执行请求
    NSError *error = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    return objs;
}


+(BOOL)deleteDataInDatabase:(NSManagedObject *) managedObject{
    // 传入需要删除的实体对象
    [context deleteObject:managedObject];
    // 将结果同步到数据库
    return [CoreDataHelper commint];
}

+(void)deleteDataInDatabase:(NSManagedObject *)managedObject withComplate:(ComplateHandle)complateHandle{
    // 传入需要删除的实体对象
    [context deleteObject:managedObject];
    // 将结果同步到数据库
    [CoreDataHelper commintWithCompalate:complateHandle];
}


+(BOOL)commint{
    NSError *error = nil;
    [context save:&error];
    if (error) {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
        return false;
    }
    return true;
}

+(void)commintWithCompalate:(ComplateHandle)complateHandle{
    
    NSError *error = nil;
    [context save:&error];
    BOOL isTrue=true;
    if (error) {
        isTrue=false;
    }
    complateHandle(isTrue,error);
}

@end

@implementation NSManagedObject(EntityObject)


+(id)createEntity{
    
    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:[CoreDataHelper getContext]];
    
    
    return person;
}


-(BOOL)addEntity{
    
    return [CoreDataHelper commint];
}
-(void)addEntityWithComplate:(ComplateHandle)complateHandle{
    
    return [CoreDataHelper commintWithCompalate:complateHandle];
}

-(BOOL)updateEntity{
    
    return [CoreDataHelper commint];
}


-(void)updateEntityWithComplate:(ComplateHandle)complateHandle{
    
    
    [CoreDataHelper commintWithCompalate:complateHandle];
}

-(BOOL)deleteEntity{
    
    return [CoreDataHelper deleteDataInDatabase:self];
    
}

-(void)deleteEntityWithComplate:(ComplateHandle)complateHandle{
    
    [CoreDataHelper deleteDataInDatabase:self withComplate:complateHandle];
    
}

+(NSArray *)searchDataInDatabaseWithPredicate:(NSPredicate *) predicate withNSSortDescriptors:(NSArray *)sortDescriptors{

    NSString * entityName=NSStringFromClass(self.class);
    
    return [CoreDataHelper searchDataInDatabase:entityName withPredicate:predicate withNSSortDescriptors:sortDescriptors];
}

@end
