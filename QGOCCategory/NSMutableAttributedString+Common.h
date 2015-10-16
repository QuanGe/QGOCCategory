//
//  NSMutableAttributedString+Common.h
//  QGOCCategory
//
//  Created by 张如泉 on 15/10/16.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Common)
- (NSMutableAttributedString*)addStringByWord:(NSMutableAttributedString *)word viewWidth:(CGFloat)width;
@end
