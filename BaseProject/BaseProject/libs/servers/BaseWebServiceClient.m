//
//  BaseWebServiceClient.m
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-25.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "BaseWebServiceClient.h"
#import "AFNetworking.h"

static NSString * PATH=@"http://www.webxml.com.cn/WebServices/WeatherWebService.asmx";
static NSString * WORKSPACE=@"http://WebXml.com.cn/";

@implementation BaseWebServiceClient


-(void)doTaskWebServiceWithParames:(NSMutableDictionary *)parameters withMethod:(NSString *)method{//getSupportCity
    
    NSString *soapMessage=[self getRequestDataWithMethodName:method withParames:parameters];
    NSLog(@"soapMessage=%@",soapMessage);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PATH parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"response=%@", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        NSLog(@"response=%@, error=%@", response, error);
    }];
    
}

-(NSString *)getRequestDataWithMethodName:(NSString *)methodName withParames:(NSMutableDictionary *)mutableDics{
   
    NSMutableString * mutableString=[[NSMutableString alloc] initWithString:@""];
    
    NSEnumerator * enumeratorKey = [mutableDics keyEnumerator];
    for (NSObject * key in enumeratorKey) {
        NSString * value=[mutableDics objectForKey:key];
        NSString * parmes=[NSString stringWithFormat:@"<%@>%@</%@>",key,value,key];
        [mutableString appendString:parmes];
    }
    
    NSString * msg= [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?> \n"
    "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
    "<soap12:Body>"
    "<%@ xmlns=\"%@\">"
    "%@"
    "</%@>"
    "</soap12:Body>"
    "</soap12:Envelope>",methodName,WORKSPACE,mutableString.description,methodName];
    
    return msg;
}

@end
