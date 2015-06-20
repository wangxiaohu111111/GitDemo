//
//  HeartBeatHandler.m
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "HeartBeatHandler.h"
#import "ByteUtil.h"

@implementation HeartBeatHandler


+(NSData *)sendHeartBeat{
    
    NSString * data=@"SYN";
    NSData * bytes = [data dataUsingEncoding:NSUTF8StringEncoding] ;
    
    Byte byte[] = {HEARTBEAT_SEND};
    NSData *adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    NSData *adata1 = [ByteUtil intToByte:(int)[bytes length]];
    NSData *adata2 = [ByteUtil intToByte:0];
    
    
    NSMutableData * allData=[[NSMutableData alloc] init];
    [allData appendData:adata];
    [allData appendData:adata1];
    [allData appendData:adata2];
    [allData appendData:bytes];
    
    return allData;


}

@end
