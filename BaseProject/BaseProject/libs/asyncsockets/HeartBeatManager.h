//
//  HeartBeatManager.h
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsyncSocket;

@interface HeartBeatManager : NSObject

+(HeartBeatManager *)newInstance;

-(void)regiestOnline:(AsyncSocket *)socket;
-(void)updateHeartBeatTime;
-(void)stop;

@end
