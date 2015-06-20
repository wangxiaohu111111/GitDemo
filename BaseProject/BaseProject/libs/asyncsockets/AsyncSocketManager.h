//
//  AsyncSocketManager.h
//  BaseProject
//
//  Created by wangxiaohu on 15-2-6.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//




#define  PORT 8080
#define  IP @"127.0.0.1"

#import <Foundation/Foundation.h>

@class MessageModule;

@interface AsyncSocketManager : NSObject

@property(nonatomic,strong) NSString * loginUserId;

+(AsyncSocketManager *)newInstance;

-(void)start;
-(void)stop;

-(void)sendDataPacket:(MessageModule *)messageModule;

@end
