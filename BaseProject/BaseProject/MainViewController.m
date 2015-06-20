//
//  ViewController.m
//  IOSBaseProject
//
//  Created by wangxiaohu on 15-3-16.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "MainViewController.h"
#import "XibStoryBoard.h"

@interface MainViewController (){
    
    
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden=YES;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (IBAction)toDemoAction:(id)sender {
    
    [self.navigationController pushViewController:[XibStoryBoard xibToStoryBoardOrStoryBoardTOStoryBoardNavagation:@"Demo"] animated:YES];
}


- (IBAction)nextAction:(id)sender {
    
    [self performSegueWithIdentifier:@"toSwiftTest" sender:nil];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue=%@",segue.identifier);
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
