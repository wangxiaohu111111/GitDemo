//
//  DataPacket.h
//  BaseProject
//
//  Created by wangxiaohu on 15-2-10.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPacket : NSObject

@property(nonatomic,assign) Byte type;
@property(nonatomic,assign) int dataLength;
@property(nonatomic,assign) int check;

@property(nonatomic,strong) NSString * message;

-(void)toString;

@end
