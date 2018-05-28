//
//  XLClockItem.m
//  翻页动画Demo
//
//  Created by MengXianLiang on 2018/5/28.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import "XLFoldClockItem.h"
#import "XLFoldLabel.h"

@interface XLFoldClockItem () {
    XLFoldLabel *_leftLabel;
    NSInteger _lastLeftTime;
    XLFoldLabel *_rightLabel;
    NSInteger _lastRightTime;
    UIView *_line;
    BOOL _firstSetTime;
}
@end

@implementation XLFoldClockItem

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    _leftLabel = [[XLFoldLabel alloc] init];
    [self addSubview:_leftLabel];
    
    _rightLabel = [[XLFoldLabel alloc] init];
    [self addSubview:_rightLabel];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor blackColor];
    [self addSubview:_line];
    
    _lastLeftTime = -1;
    _lastRightTime = -1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelW = self.bounds.size.width/2.0f;
    CGFloat labelH = self.bounds.size.height;
    _leftLabel.frame = CGRectMake(0, 0, labelW, labelH);
    _rightLabel.frame = CGRectMake(labelW, 0, labelW, labelH);
    
    self.layer.cornerRadius = self.bounds.size.height/10.0f;
    self.layer.masksToBounds = true;
    
    _line.bounds = CGRectMake(0, 0, self.bounds.size.width, 5);
    _line.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
}

- (void)setTime:(NSInteger)time {
    _time = time;
    [self configLeftTimeLabel:time/10];
    [self configRightTimeLabel:time%10];
}

- (void)configLeftTimeLabel:(NSInteger)time {
    if (_lastLeftTime == time && _lastLeftTime != -1) {return;}
    _lastLeftTime = time;
    NSInteger current = 0;
    switch (self.type) {
        case XLClockItemTypeHour:
            current = time == 0 ? 2 : time - 1;
            break;
        case XLClockItemTypeMinute:
            current = time == 0 ? 5 : time - 1;
            break;
        case XLClockItemTypeSecond:
            current = time == 0 ? 5 : time - 1;
            break;
        default:
            break;
    }
    [_leftLabel updateTime:current nextTime:time];
}

- (void)configRightTimeLabel:(NSInteger)time {
    if (_lastRightTime == time && _lastRightTime != -1) {return;}
    _lastRightTime = time;
    NSInteger current = 0;
    switch (self.type) {
        case XLClockItemTypeHour:
            current = time == 0 ? 4 : time - 1;
            break;
        case XLClockItemTypeMinute:
            current = time == 0 ? 9 : time - 1;
            break;
        case XLClockItemTypeSecond:
            current = time == 0 ? 9 : time - 1;
            break;
        default:
            break;
    }
    [_rightLabel updateTime:current nextTime:time];
}

#pragma mark -
#pragma mark Setter
- (void)setFont:(UIFont *)font {
    _leftLabel.font = font;
    _rightLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _leftLabel.textColor = textColor;
    _rightLabel.textColor = textColor;
}
@end
