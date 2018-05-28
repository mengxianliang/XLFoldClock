//
//  XLTimeLabel.h
//  翻页动画Demo
//
//  Created by MengXianLiang on 2018/5/28.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLFoldLabel : UIView

- (void)updateTime:(NSInteger)time nextTime:(NSInteger)nextTime;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *textColor;


@end
