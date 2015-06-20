//
//  ChartCommon.m
//  DrawLib
//
//  Created by wangxiaohu on 14-12-2.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//

#import "ChartCommon.h"
#import "Constant.h"


@implementation LocationPoint

@synthesize xPoint,yPoint;

@end

@interface ChartCommon(){
    
}

@end

@implementation ChartCommon


@synthesize type;


static int oldXDis;

+(void)setDefaultXDur:(int)xdur{
    oldXDis=xdur;
}

-(id)initWithSize:(CGSize)size withDelegate:(id<ChartCommonDataSource>)chartCommonDataSource{
    self=[super init];

    if (self) {
        [self initCommonWithSize:size with:chartCommonDataSource];
    }
    
    return self;
}

-(void)initCommonWithSize:(CGSize)size with:(id<ChartCommonDataSource>) chartCommonDataSource{
    type=[chartCommonDataSource createXType];
    
    if (type==DAY) {
        xData=[self createDayTypeXZBData];
    }else{
        xData=[chartCommonDataSource createXZBData];
    }
    
    yNum=[chartCommonDataSource createYZBnum];
    xDis=[chartCommonDataSource createXDis];
    yDis=[chartCommonDataSource createYDis];
    
    linePointss=[self resetPointsWith:chartCommonDataSource withSize:size];
}

-(NSMutableArray *)createDayTypeXZBData{
    NSMutableArray *xDatas=[[NSMutableArray alloc] init];
    int h=0;
    for (int i=0; i<=48; i++) {
        NSString * min=@"00";
        if (i%2==0) {
            h++;
        }else{
            min=@"30";
        }
        NSString * time =[NSString stringWithFormat:@"%d:%@",(h-1),min];
        [xDatas addObject:time];
    }
    return xDatas;
}

-(NSMutableArray *)resetPointsWith:(id<ChartCommonDataSource>) chartCommonDataSource withSize:(CGSize)size{
    
    int maxY=yNum*yDis;
    
    NSMutableArray * newPointxss=[[NSMutableArray alloc] init];
    
    NSMutableArray * pointxss=[chartCommonDataSource createLinePoint];
    
    for (NSMutableArray * pointxs in pointxss) {
        
        NSMutableArray * newPointxs=[[NSMutableArray alloc] init];
        for (LocationPoint * point in pointxs) {
            LocationPoint * newPoint=[[LocationPoint alloc] init];
            
            float arfa=point.yPoint*1.0f/maxY;
            newPoint.yPoint=(size.height-2*panding)*arfa;
            
            if (type==NUM) {
                float arfx=(xDis*1.0f)/oldXDis;
                newPoint.xPoint=point.xPoint*arfx;
                
            }else if (type==DAY){
                int allDay=24*60*60;
                float arfx=point.xPoint*1.0f/allDay;
                newPoint.xPoint=arfx*(xDis*(xData.count));
            }else if ((type==MONTH)||(type==WEEK)){
                
                long allMW=xData.count*24*60*60;
                float arfx=point.xPoint*1.0f/allMW;
                newPoint.xPoint=arfx*(xDis*(xData.count));
            }
            
            
            [newPointxs addObject:newPoint];
        }
        [newPointxss addObject:newPointxs];

    }
    
    return newPointxss;
}



-(void)drawXYLineWithCGContextRef:(CGContextRef)context withSize:(CGSize)size{
    
    CGContextSetShouldAntialias(context, YES );
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, xy_line_color.CGColor);
    
    CGContextMoveToPoint(context,panding,size.height-panding);
    CGContextAddLineToPoint(context, panding, 0);
    
    
    CGContextMoveToPoint(context,panding,size.height-panding);
    CGContextAddLineToPoint(context, size.width, size.height-panding);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}

-(void)drawXYBGLineWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withX:(int)x hang:(int)hNum lie:(int)lNum{
    
    CGContextSetShouldAntialias(context, NO); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 0.5);
    
    int newYDis=(size.height-2*panding)/hNum;
    CGContextSetStrokeColorWithColor(context, bg_line_color.CGColor);
    for (int i=1; i<=hNum; i++) {
        int endYPoint=size.height-panding-newYDis*i;
        int endXPoint=x+xDis*lNum+panding;
        if (endXPoint<=panding) {
            endXPoint=panding+1;
        }
        
        CGContextMoveToPoint(context,panding+1,endYPoint);
        CGContextAddLineToPoint(context, endXPoint, endYPoint);
    }
    
    for (int i=1; i<=lNum; i++) {
        int xPoint=x+panding+xDis*i;
        if (xPoint<=panding) {
            xPoint=panding+1;
        }else if((xPoint>=size.width)&&(i==lNum)){
            xPoint=size.width-1;
        }
        CGContextMoveToPoint(context,xPoint,size.height-panding-1);
        CGContextAddLineToPoint(context, xPoint, size.height-panding-hNum*newYDis);
    }
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
    
}
-(void)drawXYTextWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withX:(int)x hang:(int)hNum lie:(int)lNum{
    
    CGContextSetShouldAntialias(context, NO); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 0.5);
    
    int newYDis=(size.height-2*panding)/hNum;
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    UIFont *font = [UIFont boldSystemFontOfSize:8.0];
    CGContextSetRGBFillColor (context, 0.0, 0.0, 0.0, 0.5);
    for (int i=0; i<=hNum; i++) {
        //绘制纵坐标文字
        NSString *text=[NSString stringWithFormat:@"%d",i*yDis];
        if (text.length==1) {
            text=[NSString stringWithFormat:@"     %@",text];
        }else if (text.length==2){
            text=[NSString stringWithFormat:@"    %@",text];
        }else if(text.length==3){
            text=[NSString stringWithFormat:@"  %@",text];
        }
        [text drawInRect:CGRectMake(2, size.height-panding-newYDis*i-4, 25, 15) withFont:font];
    }
    
    for (int i=0; i<=lNum; i++) {
        int xPoint=x+panding+xDis*i;
        if (xPoint<panding) {
            xPoint=panding;
        }else if((xPoint>=size.width)&&(i==lNum)){
            xPoint=size.width-1;
        }
        //绘制横坐标文字
        if ((xPoint!=panding)&&(xPoint<(size.width-1))) {
            NSString *text=@"";
            if (type==DAY) {
                if (i==lNum) {
                    continue;
                }
                text=[xData objectAtIndex:i];
            }else if(type==MONTH){
                text=[NSString stringWithFormat:@"%d日",i];
            }else if(type==WEEK){
                if (i==lNum) {
                    continue;
                }
                text=[xData objectAtIndex:i];
            }else if (type==NUM){
                if (i==lNum) {
                    continue;
                }
                text=[xData objectAtIndex:i];
            }
            [text drawInRect:CGRectMake(xPoint-10, size.height-panding+3, 40, 15) withFont:font];
        }
        
    }
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
    
}


-(void)drawXYLineWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withX:(int)x hang:(int)hNum lie:(int)lNum{

    [self drawXYBGLineWithCGContextRef:context withSize:size withX:x hang:hNum lie:lNum];
    [self drawXYTextWithCGContextRef:context withSize:size withX:x hang:hNum lie:lNum];
    
}


-(void)clearnCanvasWithCGContextRef:(CGContextRef)context withSize:(CGSize)size{
    
    CGContextSetFillColorWithColor(context, ITEM_CHART_BASE_COLOR.CGColor);
    CGContextFillRect(context,CGRectMake(0, 0, size.width, size.height));
}



-(void)changeXYSystemWithPoint:(LocationPoint *) point size:(CGSize)size{


    int x=panding+point.xPoint;
    int y=size.height-panding-point.yPoint;
    
    point.xPoint=x;
    point.yPoint=y;
}

-(void)zoomUp{
   
}

-(void)zoomDown{

}


@end
