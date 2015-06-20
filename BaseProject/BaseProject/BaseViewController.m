//
//  BaseViewController.m
//  DDYHProject
//
//  Created by wangxiaohu on 14-2-1.
//  Copyright (c) 2014年 ninecube. All rights reserved.
//

#import "BaseViewController.h"


#import "DaiDodgeKeyboard.h"

@implementation UIView (FindFirstResponder)

-(UIView*) findFirstResponder {
    
    if (self.isFirstResponder) return self;
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) return firstResponder;
    }
    return nil;
    
}

@end

@interface BaseViewController (){
}

-(UIToolbar*) createToolbar;
-(void) nextTextField;
-(void) prevTextField;
-(void) textFieldDone;
-(NSArray*) inputViews;

@end

@implementation BaseViewController

@synthesize baseViewControllerDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden=NO;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setNavigationBg];
}

- (void)setNavigationBg{
    
    [[UINavigationBar appearance] setBarTintColor:BASE_COLOR];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = kColorWithInt(255);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                  [UIColor whiteColor], NSForegroundColorAttributeName,
                  [UIFont boldSystemFontOfSize:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];

    
    [self setLeftBarButtonItemView];
    [self setTitleView];
    [self setRightBarButtonItemView];
}


- (void)setLeftBarButtonItemView{
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self createNavLeftView]];
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;
    self.navigationItem.backBarButtonItem=temporaryBarButtonItem;
}


-(void)setTitleView{
    self.navigationItem.titleView = [self createNavTitleView];

}

- (void)setRightBarButtonItemView{
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView: [self createNavRightView]];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

-(UIView *)createNavLeftView{

    return nil;
}

-(UIView *)createNavTitleView{
    
    UILabel * titleView=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [titleView setText:@"标题栏"];
    [titleView setTextColor:[UIColor whiteColor]];
    [titleView setFont:[UIFont systemFontOfSize:18]];
    titleView.textAlignment=NSTextAlignmentCenter;
    
    return titleView;
}

-(UIView *)createNavRightView{
    
    return nil;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [self loadKeyBoardListener];
}

-(void)loadKeyBoardListener{
    UIToolbar *toolBar = [self createToolbar];
    for (UIView *v in self.view.subviews) {
        if (([v respondsToSelector:@selector(setText:)])&&([v class]!=[UILabel class])) {
            [v performSelector:@selector(setDelegate:) withObject:self];
            [v performSelector:@selector(setInputAccessoryView:) withObject:toolBar];
        }
    }
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
}


#pragma mark - UITextViewDelegate

-(BOOL) textView : (UITextView*) textView shouldChangeTextInRange : (NSRange) range replacementText : (NSString*) text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn : (UITextField*) textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - private

-(UIToolbar*) createToolbar {
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextTextField)];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"上一个"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(prevTextField)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(textFieldDone)];
    toolBar.items = @[prevButton, nextButton, space, done];
    return toolBar;
    
}

-(void) nextTextField {
    NSUInteger currentIndex = [[self inputViews] indexOfObject:[self.view findFirstResponder]];
    NSUInteger nextIndex = currentIndex + 1;
    nextIndex += [[self inputViews] count];
    nextIndex %= [[self inputViews] count];
    UITextField *nextTextField = [[self inputViews] objectAtIndex:nextIndex];
    [nextTextField becomeFirstResponder];
}

-(void) prevTextField {
    NSUInteger currentIndex = [[self inputViews] indexOfObject:[self.view findFirstResponder]];
    NSUInteger prevIndex = currentIndex - 1;
    prevIndex += [[self inputViews] count];
    prevIndex %= [[self inputViews] count];
    UITextField *nextTextField = [[self inputViews] objectAtIndex:prevIndex];
    [nextTextField becomeFirstResponder];
}

-(void) textFieldDone {
    [[self.view findFirstResponder] resignFirstResponder];
}

-(NSArray*) inputViews {
    NSMutableArray *returnArray = [NSMutableArray array];
    for (UIView *eachView in self.view.subviews) {
        if ([eachView respondsToSelector:@selector(setText:)]) {
            [returnArray addObject:eachView];
        }
    }
    return returnArray;
}



-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
