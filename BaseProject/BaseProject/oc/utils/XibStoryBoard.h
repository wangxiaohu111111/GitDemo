//
//  XibStoryBoard.h
//  OneLine
//
//  Created by wangxiaohu on 13-12-21.
//  Copyright (c) 2013年 ninecube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XibStoryBoard : NSObject

//从xib的viewcontroll中启动storyboard   或者   从一个storyboard切换到另一个storyboard：
+(void)xibToStoryBoardOrStoryBoardTOStoryBoard:(NSString *)storyBoardName andControllerView:(UIViewController *)controller;
+(UIViewController *)xibToStoryBoardOrStoryBoardTOStoryBoardNavagation:(NSString *)storyBoardName;
//从storyboard切换到xib：
+(void)toXib:(NSString *)xibName;
//从xib或者storyboard中启动里一个storyboard的某一个controller上：
+(void)toStoryboardWithIdentifier:(NSString *)identifierName andStoryBoardName:(NSString *)storyBoardName andControllerView:(UIViewController *)controller withData:(id)data;

+(void)toStoryboardWithIdentifierNavagation:(NSString *)identifierName andStoryBoardName:(NSString *)storyBoardName andControllerView:(UINavigationController *)controller withData:(id)data;

@end
