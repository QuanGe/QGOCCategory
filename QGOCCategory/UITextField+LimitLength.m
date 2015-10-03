//
//  UITextField+LimitLength.m
//  QGOCCategory
//
//  Created by 张如泉 on 15/10/3.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation UITextField (LimitLength)
- (NSInteger)qgoc_limitLengthNum
{
    return [objc_getAssociatedObject(self, @selector(qgoc_limitLengthNum)) integerValue];
}

- (void)qgoc_setLimitTextLength:(NSInteger)length
{
    objc_setAssociatedObject(self, @selector(qgoc_limitLengthNum), [NSNumber numberWithInteger:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTextLengthLimit:(id)sender
{
    NSNumber *lengthNumber = objc_getAssociatedObject(self, @selector(qgoc_limitLengthNum));
    NSInteger textLength = [lengthNumber integerValue];
    //if the systemVersion up 8.0
    if([[[[UIDevice currentDevice] systemVersion]substringToIndex:1] floatValue] != 7.0)
    {
        if(self.text.length <= textLength)
            return;
        self.text = [self.text substringToIndex:textLength];
        return;
        
    }
    //if the systemVersion is 7.x
    BOOL isChinese;
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString: @"en-US"]) {
        isChinese = NO;
    }
    else
    {
        isChinese = YES;
    }
    
    NSString *str = [[self text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) {
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            //NSLog(@"汉字");
            if ( str.length> textLength) {
                NSString *strNew = [NSString stringWithString:str];
                [self setText:[strNew substringToIndex:textLength]];
            }
        }
        else
        {
            //NSLog(@"输入的英文还没有转化为汉字的状态");
            
        }
    }
    else if(self.text.length > textLength){
        self.text = [self.text substringToIndex:textLength];
    }
}
@end
