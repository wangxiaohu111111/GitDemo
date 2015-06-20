//
//  BaseViewController.h
//  DDYHProject
//
//  Created by wangxiaohu on 14-2-1.
//  Copyright (c) 2014年 ninecube. All rights reserved.
//
@protocol BaseViewControllerDelegate <NSObject>

-(void)callBackWith:(id)sender;

@end


#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>{
    
}

@property (nonatomic,retain) id<BaseViewControllerDelegate> baseViewControllerDelegate;

-(UIView *)createNavLeftView;
-(UIView *)createNavTitleView;
-(UIView *)createNavRightView;

@end
