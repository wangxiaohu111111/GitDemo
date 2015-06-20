//
//  ChartCommon.h
//  DrawLib
//
//  Created by wangxiaohu on 14-12-2.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//



#define xy_line_color [UIColor colorWithRed:35/255.0f green:35/255.0f blue:35/255.0f alpha:1]
#define bg_line_color [UIColor colorWithRed:231/255.0f green:228/255.0f blue:227/255.0f alpha:1]
#define line_color [UIColor colorWithRed:80/255.0f green:196/255.0f blue:211/255.0f alpha:1]
#define line_fill_color [UIColor colorWithRed:227/255.0f green:237/255.0f blue:238/255.0f alpha:1.0f]

#define panding 25 //统计图边距

#import <Foundation/Foundation.h>


//时间类型（横坐标）
typedef enum{
    MONTH=1, //日期
    WEEK=2, //周
    DAY=3, //小时
    NUM=4  //数据
} DayType;


@protocol ChartCommonDataSource <NSObject>

/**
 *创建x坐标对应的点
 **/
-(NSMutableArray *)createXZBData;
/**
 *创建yx坐标对应的间距大小
 **/
-(int)createXDis;
/**
 *创建y坐标对应的点
 **/
-(int)createYZBnum;
/**
 *创建y坐标对应的间距大小
 **/
-(int)createYDis;
/**
 *创建对应的点的数据
 **/
-(NSMutableArray *)createLinePoint;
/**
*创建x坐标对应的类型
**/
-(DayType)createXType;

@end

@interface LocationPoint : NSObject

@property(nonatomic,assign) CGFloat xPoint;
@property(nonatomic,assign) CGFloat yPoint;

@end

@interface ChartCommon : NSObject{

    
    NSMutableArray * linePointss;//显示数据
    NSMutableArray * xData;//很坐标数据
    int yNum; //纵坐标个数
    int xDis; //横坐标距离
    int yDis; //纵坐标间隔数
    DayType type; //横坐标类型
    

}

@property(nonatomic,assign) DayType type;//横坐标类型

//初始化数据
-(id)initWithSize:(CGSize)size withDelegate:(id<ChartCommonDataSource>)chartCommonDataSource;
//创建DayType的横坐标数据
-(NSMutableArray *)createDayTypeXZBData;
//绘制xy坐标数据
-(void)drawXYLineWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withX:(int)x hang:(int)hNum lie:(int)lNum;
//绘制xy坐标
-(void)drawXYLineWithCGContextRef:(CGContextRef)context withSize:(CGSize)size;
//清理画布
-(void)clearnCanvasWithCGContextRef:(CGContextRef)context withSize:(CGSize)size;
//改变坐标系位置
-(void)changeXYSystemWithPoint:(LocationPoint *) point size:(CGSize)size;


+(void)setDefaultXDur:(int)xdur;
/**
 *放大
 **/
-(void)zoomUp;
/**
 *缩小
 **/
-(void)zoomDown;


@end
