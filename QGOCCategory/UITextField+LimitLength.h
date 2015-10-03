//
//  UITextField+LimitLength.h
//  QGOCCategory
//
//  Created by 张如泉 on 15/10/3.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LimitLength)

- (NSInteger)qgoc_limitLengthNum;
- (void)qgoc_setLimitTextLength:(NSInteger)length;
@end
