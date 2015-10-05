//
//  ViewController.m
//  QGOCCategoryDemo
//
//  Created by 张如泉 on 15/10/3.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import "ViewController.h"
#import "QGOCCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"设备空余容量%@ 当前软件版本号：%@ 当前使用的设备是:%@",[UIDevice qgocc_freeDiskSpaceBytes],[UIDevice qgocc_appVersion],[UIDevice qgocc_deviceVersion] );
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
