//
//  MessageModule.h
//  BaseProject
//
//  Created by wangxiaohu on 15-2-6.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModule : NSObject

@property(nonatomic,retain) NSString * sendUserId;
@property(nonatomic,retain) NSString * reservedUserId;
@property(nonatomic,retain) NSString * title;
@property(nonatomic,retain) NSString * content;
@property(nonatomic,retain) NSString * url;
@property(nonatomic,assign) Byte type;
@property(nonatomic,retain) NSString * time;

@end
