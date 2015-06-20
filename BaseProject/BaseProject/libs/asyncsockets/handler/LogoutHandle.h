//
//  LogoutHandle.h
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocketManager.h"

@class AsyncSocket;
@class DataPacket;

@interface LogoutHandle : NSObject


-(void)parashData:(AsyncSocket *)socket with:(DataPacket *) dataPacket withTaget:(AsyncSocketManager *) socketManager;

@end
