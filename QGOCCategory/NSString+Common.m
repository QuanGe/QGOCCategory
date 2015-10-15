//
//  NSString+Common.m
//  QGOCCategory
//
//  Created by 张如泉 on 15/10/15.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)
- (NSString*)addStringByWord:(NSString *)word viewWidth:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                      attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:fontSize] }
                                         context:nil];
    CGRect addedTextRect = [[self stringByAppendingString:word] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                      attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:fontSize] }
                                         context:nil];
    CGRect addedEnterTextRect = [[[self stringByAppendingString:@"\n"] stringByAppendingString:word] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                                          attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:fontSize] }
                                                                             context:nil];
    
    if(addedTextRect.size.height == textRect.size.height)
        return [self stringByAppendingString:word];
    else if(addedTextRect.size.height == addedEnterTextRect.size.height)
        return [[self stringByAppendingString:@"\n"] stringByAppendingString:word];
    else
        return [self stringByAppendingString:word];
}

@end
