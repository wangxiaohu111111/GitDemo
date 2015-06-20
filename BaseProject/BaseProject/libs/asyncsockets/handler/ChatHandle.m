//
//  ChatHandle.m
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "ChatHandle.h"
#import "DataPacket.h"
#import "AsyncSocket.h"

@implementation ChatHandle

-(void)parashData:(AsyncSocket *)socket with:(DataPacket *) dataPacket{
    
    
    [self doMessageType:dataPacket.type];
    [dataPacket toString];
    
}

-(void)doMessageType:(Byte)type{
    NSLog(@"type=%d",type);
}

@end
