//
//  DataPacket.m
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "DataPacket.h"

@implementation DataPacket

@synthesize type,dataLength,check,message;


-(void)toString{
    
    NSMutableString * msg=[[NSMutableString alloc] init];

    [msg appendFormat:@"type=%d,datalength=%d,check=%d,message=%@",type,dataLength,check,message];
    
    NSLog(@"%@",msg);
}

@end
