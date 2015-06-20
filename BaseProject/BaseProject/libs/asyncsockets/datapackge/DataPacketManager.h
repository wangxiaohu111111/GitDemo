//
//  DataPacketManager.h
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataPacket;

@interface DataPacketManager : NSObject

//Analytical 解析
-(DataPacket *)analyticalByte:(NSData *)data;
//Assemble 组装
-(NSData *)assembleWithDataPacket:(DataPacket *)dataPacket;

@end
