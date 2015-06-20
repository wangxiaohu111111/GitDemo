//
//  LineChart.h
//  DrawLib
//
//  Created by wangxiaohu on 14-12-4.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//

#import "ChartCommon.h"

@interface LineChart : ChartCommon


@property(nonatomic,assign) BOOL isShowLayerFlag;//是否显示阴影层

//初始化LineChar
-(id)initWithSize:(CGSize)size withDataSource:(id<ChartCommonDataSource>)chartCommonDataSource;

/**
 *绘制图像
 **/
-(void)drawLineWithCGContextRef:(CGContextRef)context withSize:(CGSize)size withXPoint:(int) x;



@end
