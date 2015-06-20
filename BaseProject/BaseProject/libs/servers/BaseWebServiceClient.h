//
//  BaseWebServiceClient.h
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-25.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseWebServiceClient : NSObject


-(void)doTaskWebServiceWithParames:(NSMutableDictionary *)parameters withMethod:(NSString *)method;


@end
