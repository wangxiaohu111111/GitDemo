//
//  ViewController.m
//  FFMPEGDemo
//
//  Created by wangxiaohu on 15-2-12.
//  Copyright (c) 2015年 com.sofn.youhaog. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoFrameExtractor.h"
#import "Utilities.h"

@interface VideoViewController (){

    BOOL isFirstLoad;
    float lastFrameTime;

}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) VideoFrameExtractor *video;

-(IBAction)playButtonAction:(id)sender;
-(IBAction)showTime:(id)sender;

@end

@implementation VideoViewController

@synthesize imageView, label, playButton,video;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isFirstLoad=true;
}



- (void)loadViewz{
    
    if (!isFirstLoad) {
        
        return;
    }
//    NSString * url= @"http://santai.tv/vod/test/test_format_1.3gp";
//     NSString * url=@"http://santai.tv/vod/test/test_format_1.mp4";
//    NSString * url= @"rtsp://184.72.239.149/vod/mp4:BigBuckBunny_115k.mov";
    NSString * url=@"http://livecdn.cdbs.com.cn/fmvideo.flv";
//    NSString * url=@"http://pay.bn.comcspancspanwmivecspan2v.asf";
    //url=[Utilities bundlePath:@"sophie.mov"];
    self.video = [[VideoFrameExtractor alloc] initWithVideo:url];
    
    float DeviceWidth=[UIScreen mainScreen].bounds.size.width*1.0/320;
    // set output image size
    video.outputWidth = 426*DeviceWidth;
    video.outputHeight = 320*DeviceWidth;
    
    // video images are landscape, so rotate image view 90 degrees
    [imageView setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    isFirstLoad=false;
}

-(UIView *)createNavTitleView{
    UILabel * title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    title.text=@"播放";
    return title;
}
-(IBAction)playButtonAction:(id)sender {
    [playButton setEnabled:NO];
    [self loadViewz];
    lastFrameTime = -1;
    // seek to 0.0 seconds
    [video seekTime:0.0];
    [NSTimer scheduledTimerWithTimeInterval:1.0/30
                                     target:self
                                   selector:@selector(displayNextFrame:)
                                   userInfo:nil
                                    repeats:YES];
}

- (IBAction)showTime:(id)sender {
    NSLog(@"current time: %f s",video.currentTime);
}

#define LERP(A,B,C) ((A)*(1.0-C)+(B)*C)

-(void)displayNextFrame:(NSTimer *)timer {
    NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
    if (![video stepFrame]) {
        [timer invalidate];
        [playButton setEnabled:YES];
        return;
    }
    imageView.image = video.currentImage;
    float frameTime = 1.0/([NSDate timeIntervalSinceReferenceDate]-startTime);
    if (lastFrameTime<0) {
        lastFrameTime = frameTime;
    } else {
        lastFrameTime = LERP(frameTime, lastFrameTime, 0.8);
    }
    [label setText:[NSString stringWithFormat:@"%.0f",lastFrameTime]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
//
- (void)dealloc {
    [video release];
    [imageView release];
    [label release];
    [playButton release];
    [super dealloc];
}

@end
