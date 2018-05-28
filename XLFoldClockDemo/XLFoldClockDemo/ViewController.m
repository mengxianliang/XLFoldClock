//
//  ViewController.m
//  XLFoldClockDemo
//
//  Created by MengXianLiang on 2018/5/28.
//  Copyright © 2018年 mxl. All rights reserved.
//

#import "ViewController.h"
#import "XLFoldClock.h"

@interface ViewController () {
    NSTimer *_timer;
    XLFoldClock *_foldClock;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _foldClock = [[XLFoldClock alloc] init];
    _foldClock.frame = self.view.bounds;
    _foldClock.date = [NSDate date];
    [self.view addSubview:_foldClock];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:true];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _foldClock.frame = self.view.bounds;
}

- (void)updateTimeLabel {
    _foldClock.date = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
