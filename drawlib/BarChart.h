//
//  BarChart.h
//  DrawLib
//
//  Created by wangxiaohu on 14-12-4.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//

#import "ChartCommon.h"

@interface BarChart : ChartCommon


//初始化BarChart
-(id)initWithSize:(CGSize)size withDataSource:(id<ChartCommonDataSource>)chartCommonDataSource;

/**
 *绘制图像
 **/
-(void)drawBarWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withXPoint:(int) x;

@end
