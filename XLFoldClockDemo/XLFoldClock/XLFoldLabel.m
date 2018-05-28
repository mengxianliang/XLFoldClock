//
//  XLTimeLabel.m
//  翻页动画Demo
//
//  Created by MengXianLiang on 2018/5/28.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import "XLFoldLabel.h"

static CGFloat NextLabelStartValue = 0.01;

@interface XLFoldLabel () {
    //当前时间label
    UILabel *_timeLabel;
    //翻转动画label
    UILabel *_foldLabel;
    //下一个时间label
    UILabel *_nextLabel;
    //放置label的容器
    UIView *_labelContainer;
    //刷新UI工具
    CADisplayLink *_link;
    //动画执行进度
    CGFloat _animateValue;
}
@end

@implementation XLFoldLabel

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    _labelContainer = [[UIView alloc] init];
    _labelContainer.backgroundColor = [UIColor colorWithRed:46/255.0f green:43/255.0f blue:46/255.0f alpha:1];
    [self addSubview:_labelContainer];
    
    _timeLabel = [[UILabel alloc] init];
    [self configLabel:_timeLabel];
    [_labelContainer addSubview:_timeLabel];
    
    _nextLabel = [[UILabel alloc] init];
    [self configLabel:_nextLabel];
    _nextLabel.hidden = true;
    //设置显示角度，为了能够显示上半部分，下半部分隐藏
    _nextLabel.layer.transform = [self nextLabelStartTransform];
    [_labelContainer addSubview:_nextLabel];
    
    
    _foldLabel = [[UILabel alloc] init];
    [self configLabel:_foldLabel];
    [_labelContainer addSubview:_foldLabel];
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAnimateLabel)];
}

- (void)configLabel:(UILabel *)label {
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:186/255.0f green:183/255.0f blue:186/255.0f alpha:1];
    label.font = [UIFont boldSystemFontOfSize:150];
    label.font = [UIFont fontWithName:@"AmericanTypewriter-Condensed" size:150];
    label.layer.masksToBounds = true;
    label.backgroundColor = [UIColor colorWithRed:46/255.0f green:43/255.0f blue:46/255.0f alpha:1];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _labelContainer.frame = self.bounds;
    _timeLabel.frame = _labelContainer.bounds;
    _nextLabel.frame = _labelContainer.bounds;
    _foldLabel.frame = _labelContainer.bounds;
}

#pragma mark -
#pragma mark 默认label起始角度
- (CATransform3D)nextLabelStartTransform {
    CATransform3D t = CATransform3DIdentity;
    t.m34  = CGFLOAT_MIN;
    t = CATransform3DRotate(t,M_PI * NextLabelStartValue, -1, 0, 0);
    return t;
}


#pragma mark -
#pragma mark 动画相关方法
- (void)start {
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop {
    [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateAnimateLabel {
    _animateValue += 2/60.0f;
    if (_animateValue >= 1) {
        [self stop];
        return;
    }
    CATransform3D t = CATransform3DIdentity;
    t.m34  = CGFLOAT_MIN;
    //绕x轴进行翻转
    t = CATransform3DRotate(t, M_PI*_animateValue, -1, 0, 0);
    if (_animateValue >= 0.5) {
        //当翻转到和屏幕垂直时，翻转y和z轴
        t = CATransform3DRotate(t, M_PI, 0, 0, 1);
        t = CATransform3DRotate(t, M_PI, 0, 1, 0);
    }
    _foldLabel.layer.transform = t;
    //当翻转到和屏幕垂直时，切换动画label的字
    _foldLabel.text = _animateValue >= 0.5 ? _nextLabel.text : _timeLabel.text;
    //当翻转到指定角度时，显示下一秒的时间
    _nextLabel.hidden = _animateValue <= NextLabelStartValue;
}

#pragma mark -
#pragma mark Setter
- (void)setFont:(UIFont *)font {
    _timeLabel.font = font;
    _foldLabel.font = font;
    _nextLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _timeLabel.textColor = textColor;
    _foldLabel.textColor = textColor;
    _nextLabel.textColor = textColor;
}

- (void)updateTime:(NSInteger)time nextTime:(NSInteger)nextTime {
    _timeLabel.text = [NSString stringWithFormat:@"%zd",time];
    _foldLabel.text = [NSString stringWithFormat:@"%zd",time];
    _nextLabel.text = [NSString stringWithFormat:@"%zd",nextTime];
    _nextLabel.layer.transform = [self nextLabelStartTransform];
    _nextLabel.hidden = true;
    _animateValue = 0.0f;
    [self start];
}

@end
