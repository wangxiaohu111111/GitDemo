//
//  AsyncSocketManager.m
//  BaseProject
//
//  Created by wangxiaohu on 15-2-6.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "AsyncSocket.h"
#import "AsyncSocketManager.h"

#import "HeartBeatHandler.h"
#import "DataPacketManager.h"
#import "DataPacket.h"

#import "LoginHandle.h"
#import "LogoutHandle.h"
#import "ChatHandle.h"

#import "HeartBeatManager.h"

#import "MessageModule.h"
#import "UserInfo.h"
#import "XHObject.h"
#import "ByteUtil.h"

static int socket_tag=0;

static AsyncSocketManager * asyncSocketManager;
static BOOL isStart=false;


@interface AsyncSocketManager()<AsyncSocketDelegate>{
    
    AsyncSocket * socket;
    DataPacketManager * dataPacketManager;
    NSTimer * nsTimer;

}

@end

@implementation AsyncSocketManager

@synthesize loginUserId;

- (instancetype)init{

    if (asyncSocketManager==nil) {
        
        asyncSocketManager=[super init];
        dataPacketManager=[[DataPacketManager alloc] init];
    }
    
    return asyncSocketManager;
}

+(AsyncSocketManager *)newInstance{

    if (asyncSocketManager==nil) {
        asyncSocketManager=[[AsyncSocketManager alloc] init];
    }
    
    return asyncSocketManager;
}

-(void)start{
    if (!isStart) {
        socket=[[AsyncSocket alloc] initWithDelegate:self];
        NSError *error;
        BOOL isConnected=[socket connectToHost:IP onPort:PORT error:&error];
        if (!isConnected) {
            NSLog(@"connected fail msg=%@",[error description]);
        }else{
            NSLog(@"connected success!");
        }
        isStart=true;
    }
}


- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"didConnectToHost host=%@,port=%d",host,port);
    [sock readDataWithTimeout:-1 tag:0];
    [sock writeData:[self login] withTimeout:10 tag:socket_tag];
    nsTimer=[NSTimer scheduledTimerWithTimeInterval:dur target:self selector:@selector(sendHeartBeat:) userInfo:nil repeats:YES];
}

-(void)sendHeartBeat:(id)obj{
    NSData * data= [HeartBeatHandler  sendHeartBeat];
    [socket writeData:data withTimeout:10 tag:socket_tag];
}


-(NSData *)login{
    
    UserInfo * userInfo=[[UserInfo alloc] init];
    userInfo.id=[NSString stringWithFormat:@"100011"] ;
    userInfo.userName=@"xiaohu";
    NSString * message=[XHObject changeNSObjectToJson:userInfo];
    
    DataPacket * dataPacket=[[DataPacket alloc] init];
    dataPacket.type=LOGIN;
    dataPacket.message=message;
    
    NSData * allData= [dataPacketManager assembleWithDataPacket:dataPacket];
    self.loginUserId=userInfo.id;
    return allData;
}

-(void)sendDataPacket:(MessageModule *)messageModule{
    
    messageModule.sendUserId=loginUserId;
    
    NSString * message=[XHObject changeNSObjectToJson:messageModule];
    
    DataPacket * dataPacket=[[DataPacket alloc] init];
    dataPacket.type=messageModule.type;
    dataPacket.message=message;
    
    [dataPacket toString];
    NSData * allData= [dataPacketManager assembleWithDataPacket:dataPacket];
    if (allData!=nil) {
        [socket writeData:allData withTimeout:10 tag:socket_tag];
    }
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    DataPacket * dataPacket= [dataPacketManager analyticalByte:data];
    if (dataPacket!=nil) {
        //TODO,更新用户心跳时间
        [[HeartBeatManager newInstance] updateHeartBeatTime];
        if (dataPacket.type==LOGIN) {
            [[[LoginHandle alloc] init] parashData:sock with:dataPacket];
        }else if (dataPacket.type==LOGINOUT){
            [[[LogoutHandle alloc] init] parashData:sock with:dataPacket withTaget:self];
        }else if (dataPacket.type==HEARTBEAT_RESPONSE){
            
        }else if (dataPacket.type==CHAT_TEXT){
            [[[ChatHandle alloc] init] parashData:sock with:dataPacket];
        }else if (dataPacket.type==CHAT_IMAGE){
            [[[ChatHandle alloc] init] parashData:sock with:dataPacket];
        }else if (dataPacket.type==CHAT_AV){
            [[[ChatHandle alloc] init] parashData:sock with:dataPacket];
        }else if (dataPacket.type==USER_MESSAGE){
            [[[ChatHandle alloc] init] parashData:sock with:dataPacket];
        }
    }
    [sock readDataWithTimeout:-1 tag:socket_tag];
    
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
    
    NSLog(@"onSocketDidDisconnect error=%@,debug=%@",[err description],[err debugDescription]);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock{
    NSLog(@"onSocketDidDisconnect");
    if (isStart) {
        //TODO,重新连接
        [self stop];
        [NSThread sleepForTimeInterval:dur*3];
        [self start];
    }
    
}

-(void)stop{
    if (socket!=nil) {
        if (nsTimer!=nil) {
           [nsTimer invalidate];
        }
        [socket disconnect];
        isStart=false;
    }
}


@end
