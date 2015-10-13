//
//  testPopWindowViewController.m
//  QGOCCategoryDemo
//
//  Created by 张如泉 on 15/10/12.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import "testPopWindowViewController.h"
#import "UIViewController+PopWindow.h"
#import "UIView+VFL.h"
@implementation testPopWindowViewController

- (void)loadView
{
    [super loadView];
    [self qgocc_buildPopBoxView];
    [self qgocc_updateTitle:@"测试弹窗哦"];
    UITextField * input = [[UITextField alloc] init];
    {
        [self.qgocc_popBoxView addSubview:input];
        [input qgocc_configConstraintsWithParentView:self.qgocc_popBoxView rect:CGRectMake(100, 100, 200, 50) marginRightAndBottom:CGPointZero];
    }
    
}
@end
