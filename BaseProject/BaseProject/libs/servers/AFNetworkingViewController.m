//
//  AFNetworkingViewController.m
//  BaseProject
//
//  Created by wangxiaohu on 15-4-13.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import "BaseWebServiceClient.h"

@interface AFNetworkingViewController ()

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self performSelectorInBackground:@selector(requestUseAFN_V2:) withObject:nil];
}


-(void)requestUseAFN_V2:(id)sender{
    
    NSMutableDictionary * parames=[[NSMutableDictionary alloc] init];
    [parames setObject:@"四川" forKey:@"byProvinceName"];
    
    [[[BaseWebServiceClient alloc] init] doTaskWebServiceWithParames:parames withMethod:@"getSupportCity"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
