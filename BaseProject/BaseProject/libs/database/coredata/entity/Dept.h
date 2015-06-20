//
//  Dept.h
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-25.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Emp;

@interface Dept : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * deptname;
@property (nonatomic, retain) NSSet *emps;
@end

@interface Dept (CoreDataGeneratedAccessors)

- (void)addEmpsObject:(Emp *)value;
- (void)removeEmpsObject:(Emp *)value;
- (void)addEmps:(NSSet *)values;
- (void)removeEmps:(NSSet *)values;

@end
