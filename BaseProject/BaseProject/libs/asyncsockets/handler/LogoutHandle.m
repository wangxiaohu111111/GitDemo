//
//  LogoutHandle.m
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "LogoutHandle.h"
#import "DataPacket.h"
#import "AsyncSocket.h"
#import "HeartBeatManager.h"

@implementation LogoutHandle

-(void)parashData:(AsyncSocket *)socket with:(DataPacket *) dataPacket withTaget:(AsyncSocketManager *) socketManager{
    
    [[HeartBeatManager newInstance] stop];
    
    [socketManager stop];
    
    NSLog(@"logout success...");
}


@end
