//
//  XibStoryBoard.m
//  OneLine
//
//  Created by wangxiaohu on 13-12-21.
//  Copyright (c) 2013年 ninecube. All rights reserved.
//

#import "XibStoryBoard.h"

@implementation XibStoryBoard


//从xib的viewcontroll中启动storyboard   或者   从一个storyboard切换到另一个storyboard：
+(void)xibToStoryBoardOrStoryBoardTOStoryBoard:(NSString *)storyBoardName andControllerView:(UIViewController *)controller{
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    
    UIViewController * viewController=[secondStoryboard instantiateInitialViewController];
    [controller presentViewController:viewController animated:YES completion:^{
    
    }];
}
+(UIViewController *)xibToStoryBoardOrStoryBoardTOStoryBoardNavagation:(NSString *)storyBoardName{
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    
    UIViewController * viewController=[secondStoryboard instantiateInitialViewController];
    return viewController;
}
//从storyboard切换到xib：
+(void)toXib:(NSString *)xibName{
    
}
//从xib或者storyboard中启动里一个storyboard的某一个controller上：
+(void)toStoryboardWithIdentifier:(NSString *)identifierName andStoryBoardName:(NSString *)storyBoardName andControllerView:(UIViewController *)controller withData:(id)data{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController *controllerInStroyboard= [storyboard instantiateViewControllerWithIdentifier:identifierName];
    [controllerInStroyboard setValue:data forKey:@"data"];
    [controllerInStroyboard setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [controller presentViewController:controllerInStroyboard animated:YES completion:^{
    }];
}

+(void)toStoryboardWithIdentifierNavagation:(NSString *)identifierName andStoryBoardName:(NSString *)storyBoardName andControllerView:(UINavigationController *)controller withData:(id)data{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UINavigationController *controllerInStroyboard= [storyboard instantiateViewControllerWithIdentifier:identifierName];
    [controllerInStroyboard.visibleViewController setValue:data forKey:@"data"];
    [controller pushViewController:controllerInStroyboard animated:YES];
}


@end
