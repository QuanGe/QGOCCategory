//
//  TestTextViewViewController.m
//  QGOCCategoryDemo
//
//  Created by 张如泉 on 15/10/8.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import "TestTextViewViewController.h"
#import "QGOCCategory.h"
@implementation TestTextViewViewController

- (void)loadView
{
    [super loadView];
    
    UIButton * back = [[UIButton alloc] init];
    {
        [self.view addSubview:back];
        [back setTitle:@"返回" forState:UIControlStateNormal];
        [back addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
        [back qgocc_configConstraintsWithParentView:self.view rect:CGRectMake(0, 60, 100, 50) marginRightAndBottom:CGPointZero];
    }
    
    UITextView *text = [[UITextView alloc] init];
    {
        [self.view addSubview:text];
        [text qgocc_setPlaceHolder:@"输入内容吧在这里,最多5个字"];
        [text qgocc_setMaxLengthNum:5];
        [text qgocc_configConstraintsWithParentView:self.view rect:CGRectMake(100, 60, 200, 100) marginRightAndBottom:CGPointZero];
    }
}

- (void)backToFront
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
