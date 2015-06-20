//
//  HeartBeatManager.m
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "HeartBeatManager.h"
#import "AsyncSocket.h"


static HeartBeatManager * heartBeatManager;

@interface HeartBeatManager(){

    AsyncSocket * asyncSocket;
    NSTimer * nsTimer;
    
    NSDate  * lastHeartDate;
}
@end

@implementation HeartBeatManager

- (instancetype)init{
    
    if (heartBeatManager==nil) {
        
        heartBeatManager=[super init];
        nsTimer=[NSTimer scheduledTimerWithTimeInterval:dur target:self selector:@selector(checkOnLineTime:) userInfo:nil repeats:YES];
        
    }
    
    return heartBeatManager;
}

-(void)checkOnLineTime:(id)obj{
    
    if (lastHeartDate!=nil) {
        double durTime=[[NSDate date] timeIntervalSinceDate:lastHeartDate];
        if (durTime>(dur*5)) {
            [self offLine];
        }
    }
    
}

+(HeartBeatManager *)newInstance{
    
    if (heartBeatManager==nil) {
        heartBeatManager=[[HeartBeatManager alloc] init];
    }
    
    return heartBeatManager;
}

-(void)regiestOnline:(AsyncSocket *)socket{
    asyncSocket=socket;
    lastHeartDate=[NSDate date];
}

-(void)offLine{
    lastHeartDate=nil;
    if (asyncSocket!=nil) {
        [asyncSocket disconnect];
    }
    
}

-(void)updateHeartBeatTime{
    lastHeartDate=[NSDate date];
}

-(void)stop{

    if (nsTimer!=nil) {
        lastHeartDate=nil;
        [nsTimer invalidate];
        [self offLine];
    }
}

@end
