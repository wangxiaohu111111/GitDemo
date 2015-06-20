//
//  OCChannel.m
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-19.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "OCChannel.h"

@interface OCChannel(){

    SwiftTest * swiftTest;
    
};

@end

@implementation OCChannel

- (id)init
{
    if (self = [super init]) {
        NSLog(@"OC Constructor is called.");
        swiftTest=[[SwiftTest alloc] init];
    }
    return self;
}


- (void)dealloc{
    NSLog(@"OC Destroyed is called.");

}

- (NSString *)ChannelChange:(NSInteger) channels{

    NSString * msg=[swiftTest hasAct:2];
    return msg;
}

@end
