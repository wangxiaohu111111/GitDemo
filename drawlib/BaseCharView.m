//
//  CharView.m
//  DrawLib
//
//  Created by wangxiaohu on 14-12-2.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//

#define SPEED 6


#import "BaseCharView.h"


@interface BaseCharView()<ChartCommonDataSource>{
    
    LineChart * lineCommon;
    BarChart * barChart;
    PieChart * pieChart;
    int viewWith;//view 宽度
    int viewHeight;//view 高度
    CGPoint beginPoint;//按下第一个点
    int x;//移动点
    int durX;//横坐标间隔
    int defaultDurX;//默认很坐标间距
    int durNum;//横坐标个数
    int defaultZoomNum;//默认放缩值
    
    CGFloat lastScale;//放缩比例
}

@end

@implementation BaseCharView

@synthesize chartCommonDataSource;

@synthesize chartType;


-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)createInstanceWithDelegate:(id<ChartCommonDataSource>) dataSource withType:(CHARTTYPE)charType{
    [self setMultipleTouchEnabled:YES];
    
    viewWith=self.frame.size.width;
    viewHeight=self.frame.size.height;
    self.chartCommonDataSource=dataSource;
    self.chartType=charType;
    
    if ([self.chartCommonDataSource createXType]==DAY) {
        durNum=48;
    }else{
        durNum=(int)[self.chartCommonDataSource createXZBData].count;
    }
    
    durX=[self.chartCommonDataSource createXDis];
    defaultDurX=durX;
    [ChartCommon setDefaultXDur:durX];
    
    UIPinchGestureRecognizer * pinchGR=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [self addGestureRecognizer:pinchGR];

}

- (id)initWithFrame:(CGRect)frame withDelegate:(id<ChartCommonDataSource>) dataSource withType:(CHARTTYPE)charType
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setMultipleTouchEnabled:YES];
        
        viewWith=self.frame.size.width;
        viewHeight=self.frame.size.height;
        self.chartCommonDataSource=dataSource;
        self.chartType=charType;
        
        if ([self.chartCommonDataSource createXType]==DAY) {
            durNum=48;
        }else{
            durNum=(int)[self.chartCommonDataSource createXZBData].count;
        }
        
        durX=[self.chartCommonDataSource createXDis];
        defaultDurX=durX;
        [ChartCommon setDefaultXDur:durX];
        
        UIPinchGestureRecognizer * pinchGR=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
        [self addGestureRecognizer:pinchGR];
    }
    return self;
}

-(void)pinchAction:(UIPinchGestureRecognizer *) pinch{
    if ([pinch scale]>lastScale) {
        [self zoomUP];
        lastScale = [pinch scale];
    }else if([pinch scale]<lastScale){
        [self zoomDown];
        lastScale = [pinch scale];
    }
    
}

-(void)refresh{
    //self.backgroundColor=[UIColor colorWithRed:248/255.0f green:245/255.0f blue:244/255.0f alpha:1.0f];
    x=0;
    if (chartType==LINECHART) {
        lineCommon=[[LineChart alloc] initWithSize:self.frame.size withDataSource:self];
        [self setNeedsDisplay];
    }
    if (chartType==BARCHART) {
        barChart=[[BarChart alloc] initWithSize:self.frame.size withDataSource:self];
        [self setNeedsDisplay];
    }
    if (chartType==PIECHART) {
        pieChart=[[PieChart alloc] initWithSize:self.frame.size withDelegate:self];
        [self setNeedsDisplay];
    }
    //放缩处理
    if (defaultZoomNum==0) {
        defaultZoomNum=durX;
    }else{
        if (durX>defaultZoomNum) {
            defaultZoomNum=durX;
        }
    }
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (chartType==LINECHART) {
        [lineCommon drawLineWithCGContextRef:context withSize:self.frame.size withXPoint:x*SPEED];
    }else if(chartType==BARCHART){
        [barChart drawBarWithCGContextRef:context withSize:self.frame.size withXPoint:x*SPEED];
    }else if (chartType==PIECHART){
        
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSUInteger numTouches = [touches count];
    if (numTouches==1) {
        beginPoint= [[touches anyObject] locationInView:self];
    }else if (numTouches==2){
        //TODO
    }
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSUInteger numTouches = [touches count];
    if (numTouches==1) {//拖动
        
        CGPoint nowPoint= [[touches anyObject] locationInView:self];
        int detx=(int)(nowPoint.x-beginPoint.x);
        if (detx>0) {
            x++;
        }else{
            x--;
        }
        if (x<0) {
            if (x*SPEED>(-defaultZoomNum*durNum+self.frame.size.width-panding)) {
                [self setNeedsDisplay];
            }else{//超过显示的数据
                if (detx>0) {
                    x--;
                }else{
                    x++;
                }
                return;
            }
        }else{//不能向右拖动
            x=0;
        }
    }else if (numTouches==2){//放缩
        //TODO
      
        
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSUInteger numTouches = [touches count];
    if (numTouches==1) {//拖动
        
    }else if (numTouches==2){//放缩
        //TODO
        
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}


-(void)zoomUP{
    if (durX<100) {
        durX++;
    }
    [self refresh];
    [self setNeedsDisplay];
}

-(void)zoomDown{
    if (durX>defaultDurX) {
        durX--;
    }
    [self refresh];
    [self setNeedsDisplay];
}


/**
 *创建x坐标对应的点
 **/
-(NSMutableArray *)createXZBData{
    
    
    return [self.chartCommonDataSource createXZBData];
}
/**
 *创建yx坐标对应的间距大小
 **/
-(int)createXDis{
    
    
    return durX;
}
/**
 *创建y坐标对应的点
 **/
-(int)createYZBnum{
    
    
    return [self.chartCommonDataSource createYZBnum];
}
/**
 *创建y坐标对应的间距大小
 **/
-(int)createYDis{
    
    
    return [self.chartCommonDataSource createYDis];
}
/**
 *创建对应的点的数据
 **/
-(NSMutableArray *)createLinePoint{
    
    
    return [self.chartCommonDataSource createLinePoint];
}
/**
 *创建x坐标对应的类型
 **/
-(DayType)createXType{
    
    
    return [self.chartCommonDataSource createXType];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
