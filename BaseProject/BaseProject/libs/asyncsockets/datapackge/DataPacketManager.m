//
//  DataPacketManager.m
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "DataPacketManager.h"
#import "DataPacket.h"
#import "ByteUtil.h"

@implementation DataPacketManager

-(DataPacket *)analyticalByte:(NSData *)data{
    
    DataPacket * dataPacket=[[DataPacket alloc] init];
    
    NSRange typeRange=NSMakeRange(0, 1);
    NSData * typeData= [data subdataWithRange:typeRange];
    Byte * types= (Byte *)[typeData bytes];
    Byte type=types[0];
    
    dataPacket.type=type;
    
    NSRange contentLengthRange=NSMakeRange(1, 4);
    NSData * contentLengthData= [data subdataWithRange:contentLengthRange];
    int dataLength=[ByteUtil bytesToInt:contentLengthData];
    
    dataPacket.dataLength=dataLength;
    
    
    NSRange checkLengthRange=NSMakeRange(5, 4);
    NSData * checkData= [data subdataWithRange:checkLengthRange];
    int check=[ByteUtil bytesToInt:checkData];
    
    dataPacket.check=check;
    
    NSRange messageRange=NSMakeRange(9, [data length]-9);
    NSData * messageData= [data subdataWithRange:messageRange];
    NSString * msgJson=[ByteUtil nsDataToNSString:messageData];
    
    dataPacket.message=msgJson;
    

    return dataPacket;
}

-(NSData *)assembleWithDataPacket:(DataPacket *)dataPacket{

    NSMutableData * data=[[NSMutableData alloc] init];
    
    NSData * message=[ByteUtil nsStringToNSData:dataPacket.message];
    
    Byte byte[] = {dataPacket.type};
    NSData * typeData=[[NSData alloc] initWithBytes:byte length:sizeof(byte)];
    NSData * lengthData=[ByteUtil intToByte:(int)[message length]];
    NSData * checkData=[ByteUtil intToByte:0];
    
    [data appendData:typeData];
    [data appendData:lengthData];
    [data appendData:checkData];
    [data appendData:message];
    
    
    return data;
}

@end
