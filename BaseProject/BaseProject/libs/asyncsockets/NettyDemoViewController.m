//
//  NettyDemoViewController.m
//  BaseProject
//
//  Created by wangxiaohu on 15-4-13.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "NettyDemoViewController.h"
#import "MessageModule.h"
#import "AsyncSocketManager.h"
#import "NettyDemoViewControllerCellTableViewCell.h"

@interface NettyDemoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *messagesTableView;
@property (weak, nonatomic) IBOutlet UITextField *sendMessageTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@end

@implementation NettyDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)sendAction:(id)sender {
    
    NSString * msg=self.sendMessageTextView.text;
    if (msg.length>0) {
        MessageModule * messageModule=[[MessageModule alloc] init];
        
        messageModule.reservedUserId=@"100010";
        messageModule.title=@"消息";
        messageModule.content=msg;
        messageModule.type=CHAT_TEXT;
        
        [[AsyncSocketManager newInstance] sendDataPacket:messageModule];
    }

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0){
    
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * identity=@"nettyDemoViewControllerCellTableViewCell";
    
    NettyDemoViewControllerCellTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identity];
    if (cell==nil) {
        NSArray * array= [[NSBundle mainBundle] loadNibNamed:@"NettyDemoViewControllerCellTableViewCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor=[UIColor clearColor];
    }
    
    [cell refreshUI:nil];
    
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"index=%d",(int)indexPath.item);
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
