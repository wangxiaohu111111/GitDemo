//
//  UserInfo.h
//  BaseProject
//
//  Created by wangxiaohu on 15-2-6.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(nonatomic,retain) NSString * id;
@property(nonatomic,retain) NSString * userName;
@property(nonatomic,retain) NSString * passWrod;
@property(nonatomic,assign) int gender;
@property(nonatomic,assign) int age;
@property(nonatomic,retain) NSString * occupation;
@property(nonatomic,retain) NSString * role;

@end
