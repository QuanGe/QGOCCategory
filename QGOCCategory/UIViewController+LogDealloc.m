//
//  UIViewController+LogDealloc.m
//  QGOCCategory
//
//  Created by 张如泉 on 15/10/3.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import "UIViewController+LogDealloc.h"
#import <objc/runtime.h>
@implementation UIViewController (LogDealloc)
+ (void)load {
    SEL deallocSelector = sel_registerName("dealloc");
    Method dea = class_getInstanceMethod(self, deallocSelector);
    Method logdealloc = class_getInstanceMethod(self, @selector(logDealloc));
    method_exchangeImplementations(dea, logdealloc);
}

-(void)logDealloc
{
    NSLog(@"%@ 类型的viewcontroller进行了释放",NSStringFromClass(self.class));
    [self logDealloc];
}
@end
