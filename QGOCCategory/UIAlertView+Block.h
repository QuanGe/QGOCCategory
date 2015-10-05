//
//  UIAlertView+Block.h
//  QGOCCategory
//
//  Created by 张如泉 on 15/10/5.
//  Copyright © 2015年 QuanGe. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^qgocc_UIAlertViewTapBlock) (UIAlertView *alertView, NSInteger buttonIndex);
@interface UIAlertView (Block)
+ (instancetype)qgocc_showWithTitle:(NSString *)title
                      message:(NSString *)message
                        style:(UIAlertViewStyle)style
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                     tapBlock:(qgocc_UIAlertViewTapBlock)tapBlock;

+ (instancetype)qgocc_showWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                     tapBlock:(qgocc_UIAlertViewTapBlock)tapBlock;

@property (nonatomic, copy) qgocc_UIAlertViewTapBlock qgocc_tapBlock;
@end
