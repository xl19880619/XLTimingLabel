//
//  XLTimingLabel.h
//  XLTimingLabel
//
//  Created by 谢小雷 on 16/2/15.
//  Copyright © 2016年 *. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  用在计时使用，可以增加或者减少
 */
typedef NS_ENUM(NSUInteger, XLTimingStyle) {
    /**
     *  增加
     */
    XLTimingStyleIncrease = 1,
    /**
     *  减少
     */
    XLTimingStyleCountdown = 2,
};

/**
 * 显示的时间格式
 */
typedef NS_ENUM(NSUInteger, XLDateFormatterStyle) {
    /**
     *  默认中文 8点32分54秒
     */
    XLDateFormatterStyleDefault,
    /**
     *  时分秒 8:32:54
     */
    XLDateFormatterStyleHHmmss,
    /**
     *  分秒 32:54
     */
    XLDateFormatterStylemmss,
    /**
     *  自定义 必须执行customBlock
     */
    XLDateFormatterStyleCustom
};

@interface XLTimingLabel : UILabel
/**
 *  可以在显示的时间前面加上默认字符串
 */
@property (copy, nonatomic) NSString *prefixString;

@property (nonatomic) XLTimingStyle timingStyle;
@property (nonatomic) XLDateFormatterStyle dateFormatterStyle;

/**
 *  如果XLDateFormatterStyle其他类型没有满足的条件，实现customDisplayTimeStringBlock返回自己要的时间格式
 */
@property (copy, nonatomic) NSString * (^customDisplayTimeStringBlock)(NSTimeInterval timeInterval);

/**
 *  开始计时，必须指定了timingStyle
 *
 *  @param date 自增的开始时间或者倒计时的结束时间
 */
- (void)startWithDate:(NSDate *)date;

/**
 *  倒计时结束或者stop后的Callback
 */
@property (copy, nonatomic) void (^completionBlock)(NSTimeInterval remainingTime);

/**
 *  暂停计时,superView dealloc时必须调用释放timer，否则造成memory leak
 */
- (void)stop;

@end
