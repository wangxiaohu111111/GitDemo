//
//  BaseHttpClient.h
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-25.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseHttpClient : NSObject

-(void)doTaskWithParames:(NSMutableDictionary *)parameters withMethod:(NSString *)method;

-(void)doTaskWithParames:(NSMutableDictionary *)parameters withMethod:(NSString *)method withUploadName:(NSString *)uploadName withNSDatas:(NSMutableArray *)nsDatas;


@end
