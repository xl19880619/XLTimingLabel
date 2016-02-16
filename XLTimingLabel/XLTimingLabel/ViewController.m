//
//  ViewController.m
//  XLTimingLabel
//
//  Created by 谢小雷 on 16/2/15.
//  Copyright © 2016年 *. All rights reserved.
//

#import "ViewController.h"
#import <XLTimingLabel/XLTimingLabel.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet XLTimingLabel *first;
@property (weak, nonatomic) IBOutlet XLTimingLabel *second;
@property (weak, nonatomic) IBOutlet XLTimingLabel *third;
@property (weak, nonatomic) IBOutlet XLTimingLabel *fourth;
@property (weak, nonatomic) IBOutlet XLTimingLabel *fifth;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDate *now = [NSDate date];
    self.first.timingStyle = XLTimingStyleCountdown;
    self.first.dateFormatterStyle = XLDateFormatterStyleDefault;
    [self.first startWithDate:[NSDate dateWithTimeInterval:200 sinceDate:now]];
    
    self.second.timingStyle = XLTimingStyleCountdown;
    self.second.dateFormatterStyle = XLDateFormatterStyleHHmmss;
    [self.second startWithDate:[NSDate dateWithTimeInterval:200 sinceDate:now]];
    
    __weak __typeof(&*self)weakSelf = self;
    self.third.timingStyle = XLTimingStyleCountdown;
    self.third.dateFormatterStyle = XLDateFormatterStyleCustom;
    [self.third setCustomDisplayTimeStringBlock:^NSString *(NSTimeInterval timeInerval) {
        return [weakSelf customDisplayTimeString:timeInerval];
    }];
    [self.third startWithDate:[NSDate dateWithTimeInterval:200 sinceDate:now]];
    
    self.fourth.timingStyle = XLTimingStyleIncrease;
    self.fourth.dateFormatterStyle = XLDateFormatterStylemmss;
    [self.fourth startWithDate:now];
    
    self.fifth.textAlignment = NSTextAlignmentLeft;
    self.fifth.timingStyle = XLTimingStyleIncrease;
    self.fifth.dateFormatterStyle = XLDateFormatterStyleCustom;
    [self.fifth setCustomDisplayTimeStringBlock:^NSString *(NSTimeInterval timeInerval) {
        return [weakSelf customDisplayTimeString:timeInerval];
    }];
    [self.fifth startWithDate:[NSDate dateWithTimeInterval:-10000 sinceDate:now]];
}

- (NSString *)customDisplayTimeString:(NSTimeInterval )timeInterval{
    
    return [NSString stringWithFormat:@"%d:%d",(int)timeInterval/60,(int)timeInterval%60];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
