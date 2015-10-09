//
//  UITextView+PlaceHolder.m
//  QGOCCategory
//
//  Created by 张如泉 on 15/10/8.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/objc.h>
#import <objc/runtime.h>
@implementation UITextView (PlaceHolder)

/**
 *  设置默认文本
 *  @param  placeholder:默认文本
 *  return  无
 */
- (void)qgocc_setPlaceHolder:(NSString*)placeholder
{
    if(!objc_getAssociatedObject(self, @selector(qgocc_placeholder)))
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsDisplay) name:UITextViewTextDidChangeNotification object:self];
    }
    objc_setAssociatedObject(self, @selector(qgocc_placeholder), placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 *  设置最大文字数量限制
 *  @param  maxLengthNum:最大文字数量限制
 *  return  无
 */
- (void)qgocc_setMaxLengthNum:(NSInteger)maxLengthNum
{
    objc_setAssociatedObject(self, @selector(qgocc_maxLengthNum), [NSNumber numberWithInteger:maxLengthNum], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  获取默认文本
 *  return  默认文本
 */
- (NSString *)qgocc_placeholder
{
    return objc_getAssociatedObject(self, @selector(qgocc_placeholder));
}

/**
 *  获取文字数量限制
 *  return  文字数量限制
 */
- (NSInteger)qgocc_maxLengthNum
{
    return [objc_getAssociatedObject(self, @selector(qgocc_maxLengthNum)) integerValue];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (self.superview && newSuperview == nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)drawRect:(CGRect)rect {
    if(self.text.length>[self qgocc_maxLengthNum])
        self.text = [self.text substringToIndex:[self qgocc_maxLengthNum]];
    if(self.attributedText.length>[self qgocc_maxLengthNum])
        self.attributedText = [self.attributedText attributedSubstringFromRange:NSMakeRange(0,[self qgocc_maxLengthNum])];
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0];
    if (self.font) {
        attrs[NSFontAttributeName] = self.font;
    }
    
    // 画文字
    CGRect placehoderRect;
    placehoderRect.origin = CGPointMake(5, 7);
    CGFloat w = rect.size.width - 2 * placehoderRect.origin.x;
    CGFloat h = rect.size.height;
    placehoderRect.size = CGSizeMake(w, h);
    [[self qgocc_placeholder] drawInRect:placehoderRect withAttributes:attrs];
}


@end
