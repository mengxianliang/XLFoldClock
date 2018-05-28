//
//  XLClockItem.h
//  翻页动画Demo
//
//  Created by MengXianLiang on 2018/5/28.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XLFoldClockItemType) {
    XLClockItemTypeHour = 0,
    XLClockItemTypeMinute,
    XLClockItemTypeSecond,
};

@interface XLFoldClockItem : UIView

@property (nonatomic, assign) XLFoldClockItemType type;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *textColor;

@end
