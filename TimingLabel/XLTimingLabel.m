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
    
    if (_timer) {
        [_timer invalidate];
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
    [self.timer invalidate];
    self.remainingTime = timeInterval;
    self.text = @(timeInterval).stringValue;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(increase)
                                           userInfo:nil
                                            repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    [self.timer fire];
}

- (void)increase{
    NSString *timeString = [self displayTimeForTimeInterval:self.remainingTime];
    if (self.prefixString) {
        self.text = [self.prefixString stringByAppendingString:timeString];
    }else{
        self.text = timeString;
    }
    self.remainingTime++;
}

- (void)startCountDownWithTotalTime:(NSTimeInterval)totalTime{
    [self.timer invalidate];
    self.remainingTime = totalTime;
    self.text = @(totalTime).stringValue;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(countDown)
                                           userInfo:nil
                                            repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    [self.timer fire];
}

- (void)countDown{
    //如果要改成倒计时位数变短的需求，在这里重新设置一下style就可以了
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

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
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
            [formatter setDateFormat:@"mm分ss秒"];
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
