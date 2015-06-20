//
//  CharView.h
//  DrawLib
//
//  Created by wangxiaohu on 14-12-2.
//  Copyright (c) 2014年 com.sofn.youhaog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LineChart.h"
#import "BarChart.h"
#import "PieChart.h"


typedef enum{
   LINECHART=0,
   BARCHART=1,
   PIECHART=2
} CHARTTYPE;


@interface BaseCharView : UIView

@property(nonatomic,assign) CHARTTYPE chartType;

@property(nonatomic,retain) id<ChartCommonDataSource> chartCommonDataSource;


-(void)createInstanceWithDelegate:(id<ChartCommonDataSource>) dataSource withType:(CHARTTYPE)charType;
//- (id)initWithFrame:(CGRect)frame withDelegate:(id<ChartCommonDataSource>) dataSource withType:(CHARTTYPE)charType;

-(void)refresh;

-(void)zoomUP;

-(void)zoomDown;

@end
