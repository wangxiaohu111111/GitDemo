//
//  LineChart.m
//  DrawLib
//
//  Created by wangxiaohu on 14-12-4.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//

#import "LineChart.h"

#define pi 3.141592653

@interface LineChart(){

}

@end


@implementation LineChart

@synthesize isShowLayerFlag;

-(id)initWithSize:(CGSize)size withDataSource:(id<ChartCommonDataSource>)chartCommonDataSource{
    self=[super initWithSize:size withDelegate:chartCommonDataSource];
    if (self) {
        self.isShowLayerFlag=true;
    }
    
    return self;
}

-(void)drawLineWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withXPoint:(int) x{
    
    //行数
    int hNum=yNum;
    //列数
    int lNum=(int)xData.count;
    //清理画布
    [super clearnCanvasWithCGContextRef:context withSize:size];
    
    if ((linePointss.count==1)&&isShowLayerFlag) {
        //绘制区域
        [self drawZoneWithCGContextRef:context withX:x withSize:size withPoints:[linePointss objectAtIndex:0]];
    }
    
    //绘制xy轴
    [super drawXYLineWithCGContextRef:context withSize:size];
    //绘制xy轴上得文字
    [super drawXYLineWithCGContextRef:context withSize:size withX:x hang:hNum lie:lNum];
    

    if (linePointss.count>3) {
        return;
    }
    
    for (NSMutableArray * points in linePointss) {
        //绘制点
        [self drawPointWithCGContextRef:context withSize:size withX:x withPoints:points];
        //绘制线
        [self drawLineWithCGContextRef:context withX:x withSize:size withPoints:points];
        
//        [self drawLineWarnWithCGContextRef:context withSize:size with:x withPoints:points];
    }
    
}


//绘制提醒层
-(void)drawLineWarnWithCGContextRef:(CGContextRef) context withSize:(CGSize)size with:(int)x withPoints:(NSMutableArray *)points{
    
    int top=((600*1.0f)/(yNum*yDis))*(size.height-2*panding);
//    int buttom=300;
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    
    BOOL isHeaderFlag=false;
    LocationPoint * lastPoint;
    
    for (int i=0; i<points.count; i++) {
        
        LocationPoint * newPoint=[points objectAtIndex:i];

        
        if (newPoint.xPoint<=0) {
            lastPoint=newPoint;
            
            return;
        }
        //向上
        if (newPoint.yPoint>top) {
            if (lastPoint!=nil) {
                if (!isHeaderFlag) {
                    if (lastPoint.yPoint<top) {
                        float arfx=((newPoint.yPoint-top)*1.0f)/(top-lastPoint.yPoint);
                        int arfb=newPoint.xPoint-lastPoint.xPoint;
                        int jxx=arfb/(arfx+1);
                        
                        LocationPoint * startPoint =[[LocationPoint alloc] init];
                        startPoint.xPoint=lastPoint.xPoint+jxx+x;
                        startPoint.yPoint=top;
                        
                        if (startPoint.xPoint<=0) {
                            float alfa=(startPoint.yPoint-lastPoint.yPoint)*1.0f/(startPoint.xPoint-lastPoint.xPoint);
                             int pointy=alfa*((0-x)-lastPoint.xPoint)+lastPoint.yPoint;
                            startPoint.xPoint=0;
                            
                            startPoint.yPoint=pointy;
                        }
                        
                        
                        [self changeXYSystemWithPoint:startPoint size:size];

                        
                        CGContextMoveToPoint(context, startPoint.xPoint, startPoint.yPoint);
                        isHeaderFlag=true;
                        
                        LocationPoint * nextPoint =[[LocationPoint alloc] init];
                        nextPoint.xPoint=newPoint.xPoint+x;
                        nextPoint.yPoint=newPoint.yPoint;
                        [self changeXYSystemWithPoint:nextPoint size:size];

                        CGContextAddLineToPoint(context, nextPoint.xPoint, nextPoint.yPoint);
                        
                        CGContextAddArc(context, nextPoint.xPoint, nextPoint.yPoint, 3, 0, 2*pi, 0);
                        
                    }else{
                    
                        
                        LocationPoint * nextPoint =[[LocationPoint alloc] init];
                        nextPoint.xPoint=newPoint.xPoint+x;
                        nextPoint.yPoint=newPoint.yPoint;
                        [self changeXYSystemWithPoint:nextPoint size:size];
                        
                        CGContextAddLineToPoint(context, nextPoint.xPoint, nextPoint.yPoint);
                        
                        CGContextAddArc(context, nextPoint.xPoint, nextPoint.yPoint, 3, 0, 2*pi, 0);
                    }
                }else{
                    
                    LocationPoint * nextPoint =[[LocationPoint alloc] init];
                    nextPoint.xPoint=newPoint.xPoint+x;
                    nextPoint.yPoint=newPoint.yPoint;
                    [self changeXYSystemWithPoint:nextPoint size:size];
                    
                    CGContextAddLineToPoint(context, nextPoint.xPoint, nextPoint.yPoint);
                    
                    
                    CGContextAddArc(context, nextPoint.xPoint, nextPoint.yPoint, 3, 0, 2*pi, 0);
                }
            }else{
                LocationPoint * startPoint =[[LocationPoint alloc] init];
                startPoint.xPoint=newPoint.xPoint+x;
                startPoint.yPoint=newPoint.yPoint;
                
                if (startPoint.xPoint<=0) {
                    
                }
                
                [self changeXYSystemWithPoint:startPoint size:size];
                
                CGContextMoveToPoint(context, startPoint.xPoint, startPoint.yPoint);
                isHeaderFlag=true;
            }
        }else{
            if (lastPoint.yPoint>=top) {
                float arfx=((newPoint.yPoint-top)*1.0f)/(top-lastPoint.yPoint);
                int arfb=newPoint.xPoint-lastPoint.xPoint;
                int jxx=arfb/(arfx+1);
                
                LocationPoint * endPoint =[[LocationPoint alloc] init];
                endPoint.xPoint=lastPoint.xPoint+jxx+x;
                endPoint.yPoint=top;
                [self changeXYSystemWithPoint:endPoint size:size];
                
                
                CGContextAddLineToPoint(context, endPoint.xPoint, endPoint.yPoint);
                
                CGContextAddArc(context, endPoint.xPoint, endPoint.yPoint, 3, 0, 2*pi, 0);
            }
           isHeaderFlag=false;
        }
        //向下
        lastPoint=newPoint;
    }
//    [[UIColor redColor] setFill];
//    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}

-(void)drawPointWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withX:(int)x withPoints:(NSMutableArray *) points{
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, line_color.CGColor);
    //绘制点
    for (int i=0; i<points.count; i++) {
        LocationPoint * point=[points objectAtIndex:i];
        int startXpoint=point.xPoint+x;
        if (startXpoint<=0) {
            continue;
        }
        int startYpoint=point.yPoint;
        LocationPoint * pointx=[[LocationPoint alloc] init];
        pointx.xPoint=startXpoint;
        pointx.yPoint=startYpoint;
        [self changeXYSystemWithPoint:pointx size:size];
        CGContextAddArc(context, pointx.xPoint, pointx.yPoint-1, 4, 0, 2*pi, 0);
        [line_color setFill];
        CGContextDrawPath(context, kCGPathFill);
    }
    
    CGColorSpaceRelease(Linecolorspace1);
}



-(void)drawLineWithCGContextRef:(CGContextRef)context withX:(int)x withSize:(CGSize)size withPoints:(NSMutableArray *) points{
    
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, line_color.CGColor);
    
    BOOL isHeader=false;
    
    int i=0;
    LocationPoint * lastPoint=nil;
    for (LocationPoint * point  in points) {
        
        int pointx=point.xPoint+x;
        
        if (pointx<0) {//不绘制
            lastPoint=point;
            continue;
        }else if(pointx>0){
            //正常绘制
            if (lastPoint==nil) {
                LocationPoint * newPoint=[[LocationPoint alloc] init];
                newPoint.xPoint=pointx;
                newPoint.yPoint=point.yPoint;
                [self changeXYSystemWithPoint:newPoint size:size];
                
                if (i==0) {
                    CGContextMoveToPoint(context, newPoint.xPoint, newPoint.yPoint);
                }else{
                    CGContextAddLineToPoint(context, newPoint.xPoint, newPoint.yPoint);
                }
                i++;
                continue;
                
            }
            //焦点移动绘制
            if (isHeader) {
                LocationPoint * newPoint=[[LocationPoint alloc] init];
                newPoint.xPoint=pointx;
                newPoint.yPoint=point.yPoint;
                [self changeXYSystemWithPoint:newPoint size:size];
                
                CGContextAddLineToPoint(context, newPoint.xPoint, newPoint.yPoint);
            }else{
                //计算移动坐标
                if (lastPoint==nil) {
                    LocationPoint * newPoint=[[LocationPoint alloc] init];
                    newPoint.xPoint=pointx;
                    newPoint.yPoint=point.yPoint;
                    [self changeXYSystemWithPoint:newPoint size:size];
                    CGContextAddLineToPoint(context, newPoint.xPoint, newPoint.yPoint);
                    continue;
                }else{
                    if (!isHeader) {
                        float alfa=(point.yPoint-lastPoint.yPoint)*1.0f/(point.xPoint-lastPoint.xPoint);
                        int pointy=alfa*((0-x)-lastPoint.xPoint)+lastPoint.yPoint;
                        LocationPoint * newPoint=[[LocationPoint alloc] init];
                        newPoint.xPoint=0;
                        newPoint.yPoint=pointy;
                        [self changeXYSystemWithPoint:newPoint size:size];
                        
                        CGContextMoveToPoint(context, newPoint.xPoint, newPoint.yPoint);
                        isHeader=true;
                    }
                }
                LocationPoint * newPoint=[[LocationPoint alloc] init];
                newPoint.xPoint=pointx;
                newPoint.yPoint=point.yPoint;
                [self changeXYSystemWithPoint:newPoint size:size];
                CGContextAddLineToPoint(context, newPoint.xPoint, newPoint.yPoint);
            }
            
            continue;
        }else if(pointx==0){
            isHeader=true;
            LocationPoint * newPoint=[[LocationPoint alloc] init];
            newPoint.xPoint=pointx;
            newPoint.yPoint=point.yPoint;
            [self changeXYSystemWithPoint:newPoint size:size];
            CGContextMoveToPoint(context, newPoint.xPoint, newPoint.yPoint);
            i++;
            continue;
        }
    }
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
    
}

-(void)drawZoneWithCGContextRef:(CGContextRef)context withX:(int)x withSize:(CGSize)size withPoints:(NSMutableArray *) points{
    
    if (points.count>0) {
        NSMutableArray *pointss=[[NSMutableArray alloc] init];
        
        
        
        LocationPoint * pointStart=[points objectAtIndex:0];
        LocationPoint * pointHeader=[[LocationPoint alloc] init];
        pointHeader.xPoint=pointStart.xPoint;
        pointHeader.yPoint=0;
        [pointss addObject:pointHeader];
        
        
        [pointss addObjectsFromArray:points];
        
        
        LocationPoint * pointEnd=[points objectAtIndex:(points.count-1)];
        LocationPoint * pointFooter=[[LocationPoint alloc] init];
        pointFooter.xPoint=pointEnd.xPoint;
        pointFooter.yPoint=0;
        [pointss addObject:pointFooter];
        
        
        CGContextSetShouldAntialias(context, YES ); //抗锯齿
        CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
        CGContextSetStrokeColorSpace(context, Linecolorspace1);
        CGContextSetLineWidth(context, 0.5);
        CGContextSetStrokeColorWithColor(context, line_color.CGColor);
        
        
        BOOL isHeader=false;
        
        int i=0;
        LocationPoint * lastPoint=nil;
        for (LocationPoint * point  in pointss) {
            
            int pointx=point.xPoint+x;
            
            if (pointx<0) {//不绘制
                lastPoint=point;
                
                continue;
            }else if(pointx>0){
                
                //正常绘制
                if (lastPoint==nil) {
                    LocationPoint * newPoint=[[LocationPoint alloc] init];
                    newPoint.xPoint=pointx;
                    newPoint.yPoint=point.yPoint;
                    [self changeXYSystemWithPoint:newPoint size:size];
                    
                    if (i==0) {
                        CGContextMoveToPoint(context, newPoint.xPoint, newPoint.yPoint);
                    }else{
                        CGContextAddLineToPoint(context, newPoint.xPoint, newPoint.yPoint);
                    }
                    i++;
                    continue;
                }
                
                
                //焦点移动绘制
                if (isHeader) {
                    LocationPoint * newPoint=[[LocationPoint alloc] init];
                    newPoint.xPoint=pointx;
                    newPoint.yPoint=point.yPoint;
                    [self changeXYSystemWithPoint:newPoint size:size];
                    CGContextAddLineToPoint(context, newPoint.xPoint, newPoint.yPoint);
                    continue;
                }else{
                    //计算移动坐标
                    if (lastPoint==nil) {
                        LocationPoint * newPoint=[[LocationPoint alloc] init];
                        newPoint.xPoint=pointx;
                        newPoint.yPoint=point.yPoint;
                        [self changeXYSystemWithPoint:newPoint size:size];
                        CGContextAddLineToPoint(context, newPoint.xPoint, newPoint.yPoint);
                    }else{
                        if (!isHeader) {
                            LocationPoint * newPoint=[[LocationPoint alloc] init];
                            newPoint.xPoint=0;
                            newPoint.yPoint=0;
                            [self changeXYSystemWithPoint:newPoint size:size];
                            
                            CGContextMoveToPoint(context, newPoint.xPoint, newPoint.yPoint);
                            isHeader=true;
                            
                            
                            
                            float alfa=(point.yPoint-lastPoint.yPoint)*1.0f/(point.xPoint-lastPoint.xPoint);
                            int pointy=alfa*((0-x)-lastPoint.xPoint)+lastPoint.yPoint;
                            LocationPoint * newPoint1=[[LocationPoint alloc] init];
                            newPoint1.xPoint=0;
                            newPoint1.yPoint=pointy;
                            [self changeXYSystemWithPoint:newPoint1 size:size];
                            CGContextAddLineToPoint(context, newPoint1.xPoint, newPoint1.yPoint);
                        }
                    }
                    LocationPoint * newPoint=[[LocationPoint alloc] init];
                    newPoint.xPoint=pointx;
                    newPoint.yPoint=point.yPoint;
                    [self changeXYSystemWithPoint:newPoint size:size];
                    CGContextAddLineToPoint(context, newPoint.xPoint, newPoint.yPoint);
                }
                
                continue;
            }else if(pointx==0){
                isHeader=true;
                LocationPoint * newPoint=[[LocationPoint alloc] init];
                newPoint.xPoint=pointx;
                newPoint.yPoint=0;
                [self changeXYSystemWithPoint:newPoint size:size];
                CGContextMoveToPoint(context, newPoint.xPoint, newPoint.yPoint);
                
                LocationPoint * newPoint1=[[LocationPoint alloc] init];
                newPoint1.xPoint=0;
                newPoint1.yPoint=point.yPoint;
                [self changeXYSystemWithPoint:newPoint1 size:size];
                CGContextAddLineToPoint(context, newPoint1.xPoint, newPoint1.yPoint);
                
                i++;
                continue;
            }
        }
        CGContextClosePath(context);
        [line_fill_color setFill];
        CGContextDrawPath(context, kCGPathFillStroke);
        CGColorSpaceRelease(Linecolorspace1);
    }
    
    
}


@end
