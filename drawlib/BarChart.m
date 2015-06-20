//
//  BarChart.m
//  DrawLib
//
//  Created by wangxiaohu on 14-12-4.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//

#import "BarChart.h"


#define bar_fill_color1 [UIColor colorWithRed:0/255.0f green:175/255.0f blue:219/255.0f alpha:1.0f]
#define bar_fill_color2 [UIColor colorWithRed:105/255.0f green:221/255.0f blue:50/255.0f alpha:1.0f]
#define bar_fill_color3 [UIColor colorWithRed:2202/255.0f green:0/255.0f blue:45/255.0f alpha:1.0f]


@interface BarChart (){
    
    int barwith;  //柱状图宽度
    int barNum;//柱状图个数

}

@end

@implementation BarChart

//初始化LineChar
-(id)initWithSize:(CGSize)size withDataSource:(id<ChartCommonDataSource>)chartCommonDataSource{
   
    self=[super initWithSize:size withDelegate:chartCommonDataSource];
    if (self) {
        barwith=20;
    }
    return self;
}

/**
 *绘制图像
 **/
-(void)drawBarWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withXPoint:(int) x{

    //行数
    int hNum=yNum;
    //列数
    int lNum=(int)xData.count;
    //清理画布
    [super clearnCanvasWithCGContextRef:context withSize:size];
    
    //绘制xy轴
    [super drawXYLineWithCGContextRef:context withSize:size];
    //绘制xy轴上得文字
    [super drawXYLineWithCGContextRef:context withSize:size withX:x hang:hNum lie:lNum];
    
    barNum=(int)linePointss.count;
    
    
    if (barNum==1) {
        barwith=20;
    }else if (barNum==2) {
        barwith=14;
    }else if(barNum==3){
        barwith=10;
    }else{
    
        return;
    }
    
    int index=0;
    for (NSMutableArray * points in linePointss) {
        
        [self drawBarWithCGContextRef:context withSize:size withXPoint:x withPoints:points withIndex:index];
        
        index++;
    }
    

}

-(void)drawBarWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withXPoint:(int)x  withPoints:(NSMutableArray *) points withIndex:(int)index{
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 0.5);
//    if (index==0) {
//        CGContextSetStrokeColorWithColor(context, bar_fill_color1.CGColor);
//    }else if (index==1){
//        CGContextSetStrokeColorWithColor(context, bar_fill_color2.CGColor);
//    }else if (index==2){
//        CGContextSetStrokeColorWithColor(context, bar_fill_color3.CGColor);
//    }
    
    for (LocationPoint * locationPoint in points) {
        LocationPoint * newPoint=[[LocationPoint alloc] init];
        newPoint.xPoint=locationPoint.xPoint+x;
        newPoint.yPoint=locationPoint.yPoint;
        if ((newPoint.xPoint<(panding-(barNum+1)*barwith))||(newPoint.xPoint>size.width)) {
            continue;
        }
        
        int top=size.height-panding-newPoint.yPoint;
        int buttom=size.height-panding-1;
        
        int left=newPoint.xPoint-barNum*barwith/2+index*barwith+panding;
        if (left<=panding) {
            left=panding+1;
        }
        int right=newPoint.xPoint-barNum*barwith/2+index*barwith+barwith+panding;
        if (right<=panding) {
            right=panding+1;
        }
        CGPoint zx=CGPointMake(left, buttom);
        CGPoint zs=CGPointMake(left, top);
        CGPoint ys=CGPointMake(right, top);
        CGPoint yx=CGPointMake(right, buttom);
        
        CGPoint poins[] = {zx,zs,ys,yx};
        CGContextAddLines(context,poins,4);
    }

//    [line_fill_color setFill];
    if (index==0) {
        [bar_fill_color1 setFill];
    }else if (index==1){
        [bar_fill_color2 setFill];
    }else if (index==2){
        [bar_fill_color3 setFill];
    }
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextClosePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}



@end
