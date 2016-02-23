//
//  XLTimingLabel.m
//  XLTimingLabel
//
//  Created by 谢小雷 on 16/2/15.
//  Copyright © 2016年 *. All rights reserved.
//

#import "XLTimingLabel.h"

@interface XLTimingLabel ()
@property (assign, nonatomic) NSTimeInterval remainingTime;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (nonatomic) int currentTimeInterval;

/**
 *  timingStyle == XLTimingStyleIncrease 调用
 *
 *  @param timeInterval 当前时间与开始时间的间隔
 */
- (void)startIncreaseWithTimeInterval:(NSTimeInterval)timeInterval;

/**
 *  timingStyle == XLTimingStyleCountdown 调用
 *
 *  @param totalTime 倒计时剩下的时间
 */
- (void)startCountDownWithTotalTime:(NSTimeInterval)totalTime;
@end

@implementation XLTimingLabel

- (void)dealloc{
    
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

#pragma mark - Life Cycle methods
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI{
    
    //custom user interface
    self.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - Util methods
- (void)startWithDate:(NSDate *)date{
    
    switch (self.timingStyle) {
        case XLTimingStyleIncrease: {
            NSDate *now = [NSDate date];
            [self startIncreaseWithTimeInterval:[now timeIntervalSinceDate:date]];
            break;
        }
        case XLTimingStyleCountdown: {
            [self startCountDownWithTotalTime:[date timeIntervalSinceNow]];
            break;
        }
    }
}

- (void)startIncreaseWithTimeInterval:(NSTimeInterval)timeInterval{
    [self.displayLink invalidate];
    self.remainingTime = timeInterval;
    self.text = @(timeInterval).stringValue;
    self.currentTimeInterval = CACurrentMediaTime()-1;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(increase)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)increase{
    
    if (CACurrentMediaTime()-self.currentTimeInterval > 1.0) {
        self.currentTimeInterval = CACurrentMediaTime();
        NSString *timeString = [self displayTimeForTimeInterval:self.remainingTime];
        if (self.prefixString) {
            self.text = [self.prefixString stringByAppendingString:timeString];
        }else{
            self.text = timeString;
        }
        self.remainingTime++;
    }
}

- (void)startCountDownWithTotalTime:(NSTimeInterval)totalTime{
    
    [self.displayLink invalidate];
    self.remainingTime = totalTime;
    if (totalTime <= 0) {
        [self stop];
    }else{
        self.text = @(totalTime).stringValue;
        
        self.currentTimeInterval = CACurrentMediaTime()-1;
//        [self.timer invalidate];
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)countDown{
    //如果要改成倒计时位数变短的需求，在这里重新设置一下style就可以了
//    NSLog(@"%f",CACurrentMediaTime());
    if (CACurrentMediaTime()-self.currentTimeInterval > 1.0) {
        self.currentTimeInterval = CACurrentMediaTime();
        NSString *timeString = [self displayTimeForTimeInterval:self.remainingTime];
        if (self.prefixString) {
            self.text = [self.prefixString stringByAppendingString:timeString];
        }else{
            self.text = timeString;
        }
        self.remainingTime--;
        if (self.remainingTime<=0) {
            self.remainingTime = 0;
            [self stop];
        }
    }
}

- (void)stop{
    [self.displayLink invalidate];
    self.displayLink = nil;
    if (self.completionBlock) {
        self.completionBlock(self.remainingTime);
    }
}

- (NSString *)displayTimeForTimeInterval:(NSTimeInterval)timeInterval{
    NSString *timeString = @"";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    switch (self.dateFormatterStyle) {
        case XLDateFormatterStyleDefault: {
            [formatter setDateFormat:@"HH时mm分ss秒"];
            break;
        }
        case XLDateFormatterStyleHHmmss: {
            [formatter setDateFormat:@"HH:mm:ss"];
            break;
        }
        case XLDateFormatterStylemmss: {
            [formatter setDateFormat:@"mm:ss"];
            break;
        }
        case XLDateFormatterStyleCustom: {
            if (!self.customDisplayTimeStringBlock) {
                NSAssert(self.customDisplayTimeStringBlock, @"没有自定义Block");
            }else{
                return self.customDisplayTimeStringBlock(self.remainingTime);
            }
            break;
        }
    }
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    timeString = [formatter stringFromDate:date];
    return timeString;
}
@end
