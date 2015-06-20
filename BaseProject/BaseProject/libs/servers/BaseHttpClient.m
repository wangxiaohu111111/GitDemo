//
//  BaseHttpClient.m
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-25.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "BaseHttpClient.h"

#import "AFNetworking.h"

static NSString * path=@"http://172.16.7.164:8080/sg_sa/";

@implementation BaseHttpClient


//NSString *postUrl = @"http://172.16.7.164:8080/sg_sa/produceAreaAnalys/getFoodProduceByAear.do";
//NSDictionary *parameters = @{@"cityName": @"",
//                             @"countyName": @"",
//                             @"villagesName":@""};
-(void)doTaskWithParames:(NSMutableDictionary *)parameters withMethod:(NSString *)method{
    
    NSString * postUrl=[NSString stringWithFormat:@"%@,%@",path,method];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.stringEncoding = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
    manager.responseSerializer.stringEncoding=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个将得到的是JSON
    //注意：此行不加也可以
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    //SEND YOUR REQUEST
    [manager POST:postUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSArray * msg=responseObject;
        //        for (id obj in msg) {
        //            NSDictionary * OBJS=obj;
        //            NSString * address=[OBJS objectForKey:@"productionAddr"];
        //            NSLog(@"address: %@", address);
        //        }
        //        NSString *str = [responseObject objectForKey:@"KEY 1"];
        //        NSArray *arr = [responseObject objectForKey:@"KEY 2"];
        //        NSDictionary *dic = [responseObject objectForKey:@"KEY 3"];
        
        //...
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        NSLog(@"Error: %@", error);
    }];

}

-(void)doTaskWithParames:(NSMutableDictionary *)parameters withMethod:(NSString *)method withUploadName:(NSString *)uploadName withNSDatas:(NSMutableArray *)nsDatas{
    
    NSString * postUrl=[NSString stringWithFormat:@"%@,%@",path,method];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.stringEncoding = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
    manager.responseSerializer.stringEncoding=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个将得到的是JSON
    //注意：此行不加也可以
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    //SEND YOUR REQUEST
    [manager POST:postUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *fileName = [formatter stringFromDate:[NSDate date]];
        
        for (NSData * date in nsDatas) {
            [formData appendPartWithFileData:date name:uploadName fileName:fileName mimeType:@"image/png"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


@end
