//
//  NSObject_OCChannel.h
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-19.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface OCChannel : NSObject

@property (nonatomic,retain) NSString *ChannelName;

- (NSString *)ChannelChange:(NSInteger) channels;

@end


