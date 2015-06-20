//
//  LoginHandle.m
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "LoginHandle.h"
#import "DataPacket.h"
#import "AsyncSocket.h"
#import "HeartBeatManager.h"

@implementation LoginHandle

-(void)parashData:(AsyncSocket *)socket with:(DataPacket *) dataPacket{

    
    [[HeartBeatManager newInstance] regiestOnline:socket];
    NSLog(@"login success...");
}


@end
