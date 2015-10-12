//
//  UIViewController+PopWindow.m
//  QGOCCategory
//
//  Created by 张如泉 on 15/10/11.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import "UIViewController+PopWindow.h"
#import "UIView+VFL.h"
#import <objc/objc.h>
#import <objc/runtime.h>
@implementation UIViewController (PopWindow)
- (void)setPopBoxView:(UIView *)popBoxView {
    objc_setAssociatedObject(self, @selector(popBoxView),
                             popBoxView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)popBoxView {
    return objc_getAssociatedObject(self,  @selector(popBoxView));
}

- (void)setPresentingVC:(UIViewController *)presentingVC {
    objc_setAssociatedObject(self,  @selector(popBoxView),
                             presentingVC,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)presentingVC {
    return objc_getAssociatedObject(self, @selector(popBoxView));
}

/**
 *  创建显示层,第一步要做的就是这个，可以写在[super loadView]的下面
 *  return  无
 */
- (void)qgocc_buildPopBoxView
{
    
    self.view.superview.frame=[[UIScreen mainScreen] bounds];
    self.view.superview.backgroundColor = [UIColor clearColor];
    
    UIControl * backgroundView=[[UIControl alloc] init];
    {
        [self.view addSubview:backgroundView];
        backgroundView.backgroundColor=[UIColor clearColor];
        [backgroundView addTarget:self action:@selector(onPopoverDismissAction:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView qgocc_configConstraintsWithParentView:self.view rect:CGRectMake(0, 0, 0, 0) marginRightAndBottom:CGPointZero];
    }
    
    self.popBoxView = [[UIView alloc] init];
    {
        self.popBoxView.backgroundColor=[UIColor whiteColor];
        self.popBoxView.layer.cornerRadius=5;
        [self.view addSubview:self.popBoxView];
        
        [self.popBoxView qgocc_configConstraintsWithParentView:self.view rect:CGRectMake(170, 140, self.view.frame.size.width-2*170, self.view.frame.size.height-140*2) marginRightAndBottom:CGPointZero];
       
        
        UIView *topBarView=[[UIView alloc] init];
        {
            topBarView.tag = 100;
            [self.popBoxView addSubview:topBarView];
            [topBarView qgocc_configConstraintsWithParentView:self.popBoxView rect:CGRectMake(0, 0, 0, 60) marginRightAndBottom:CGPointZero];
            
            UILabel * titileLabel = [[UILabel alloc] init];
            {
                titileLabel.textAlignment = NSTextAlignmentCenter;
                titileLabel.font = [UIFont systemFontOfSize:22];
                [topBarView addSubview:titileLabel];
                titileLabel.tag = 1000;
                
                [titileLabel qgocc_configConstraintsWithParentView:topBarView rect:CGRectMake(70, 0, 0, 0) marginRightAndBottom:CGPointMake(-70, 0)];
               
            }
            UIView * line = [[UIView alloc] init];
            {
                [topBarView addSubview:line];
                line.backgroundColor =[UIColor lightGrayColor];
                [line qgocc_configConstraintsWithParentView:topBarView rect:CGRectMake(0, 55.5, 0, 0.5) marginRightAndBottom:CGPointZero];
            }
            
        }
        
        
        
        
    }
    
    [self qgocc_addKeyboardNotificationObserver];
    
    {
        SEL viewWillAppear = sel_registerName("viewWillAppear:");
        Method dea = class_getInstanceMethod(object_getClass(self), viewWillAppear);
        Method qgocc_viewWillAppear = class_getInstanceMethod(object_getClass(self), @selector(qgocc_ViewWillAppear:));
        method_exchangeImplementations(dea, qgocc_viewWillAppear);
    }
    
    {
        SEL viewWillLayoutSubviews = sel_registerName("viewWillLayoutSubviews");
        Method dea = class_getInstanceMethod(object_getClass(self), viewWillLayoutSubviews);
        Method qgocc_viewWillLayoutSubviews = class_getInstanceMethod(object_getClass(self), @selector(qgocc_viewWillLayoutSubviews));
        method_exchangeImplementations(dea, qgocc_viewWillLayoutSubviews);
        
    }
    
}

/**
 *  返回
 *  @param  flag:是否有动画
 *  @param  completion:是否有完成block
 *  return  无
 */
-(void)qgocc_dismissViewController:(BOOL)flag completion:(void (^)(void))completion{
    
    [self removeNotification];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.popBoxView.transform=CGAffineTransformMakeScale(0.001, 0.001);
        self.popBoxView.alpha=0.f;
    } completion:^(BOOL finish){
        [self dismissViewControllerAnimated:flag completion:completion];
    }];
}

-(void)onPopoverDismissAction:(UIControl *)controlView{
    
    [self qgocc_dismissViewController:NO completion:nil];
}

/**
 *  添加键盘监控，当弹出键盘时弹框界面上移
 *  return  无
 */
-(void)qgocc_addKeyboardNotificationObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}


- (void)keyboardWillShow:(NSNotification *)notif {
    
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:0
                     animations:^{
                         self.popBoxView.transform=CGAffineTransformMakeTranslation(0, -100);
                     }
                     completion:NULL];
}

- (void)keyboardShow:(NSNotification *)notif {
    
    
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:0
                     animations:^{
                         self.popBoxView.transform=CGAffineTransformIdentity;
                         
                     }
                     completion:NULL];
}

- (void)keyboardHide:(NSNotification *)notif {
    
    
}


-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidShowNotification];
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidHideNotification];
}

/**
 *  设置弹框层的标题
 *  @param  title:标题
 *  return  无
 */
- (void)qgocc_updateTitle:(NSString*)title
{
    if(self.popBoxView == nil)
        return;
    ((UILabel*)[[self.popBoxView viewWithTag:100] viewWithTag:1000]).text =  title;
    
}

/**
 *  在最上面标题栏的view添加子控件
 *  @param  sub:子控件
 *  return  无
 */
- (void)qgocc_addTopSubView:(UIView*)sub
{
    [[self.popBoxView viewWithTag:100] addSubview:sub];
    
}

/**
 *  在当前页面弹出此弹框
 *  @param  presentingVC:当前页面
 *  return  无
 */
- (void)qgocc_presentedByPresentingVC:(UIViewController*)presentingVC
{
    
    self.preferredContentSize=CGSizeMake(self.view.frame.size.width-170*2, self.view.frame.size.height-140*2);
    self.modalPresentationStyle = UIModalPresentationFormSheet;
    self.presentingVC = presentingVC;
    [presentingVC presentViewController:self animated:NO completion:NULL];
    
}

-(void)qgocc_ViewWillAppear:(BOOL)animated{
    [self qgocc_ViewWillAppear:animated];
    [self qgocc_popupAnimationWithSpring];
}

/**
 *  当要显示的时候需要有个动画可以在viewWillAppear中做此动作
 *  return  无
 */
-(void)qgocc_popupAnimationWithSpring{
    self.popBoxView.transform=CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.popBoxView.transform=CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finish){
    }];
    
}

-(void)qgocc_viewWillLayoutSubviews{
    
    [self qgocc_viewWillLayoutSubviews];
    [self qgocc_viewWillLayout];
}

/**
 *  更新背景颜色 和大小 在viewWillLayoutSubviews中调用
 *  return  无
 */
- (void)qgocc_viewWillLayout
{
    self.view.superview.frame=[[UIScreen mainScreen] bounds];
    self.view.superview.backgroundColor = [UIColor clearColor];
}
@end
