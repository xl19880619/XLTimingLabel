//
//  XLTimingTableViewCell.m
//  XLTimingLabel
//
//  Created by 谢小雷 on 16/2/23.
//  Copyright © 2016年 *. All rights reserved.
//

#import "XLTimingTableViewCell.h"
#import "XLTimingModel.h"

@implementation XLTimingTableViewCell

- (void)dealloc{

    [self.timingLabel stop];
}

- (void)awakeFromNib {
    // Initialization code
    self.timingLabel.timingStyle = XLTimingStyleCountdown;
    self.timingLabel.dateFormatterStyle = XLDateFormatterStyleDefault;
}

- (void)setTimingModel:(XLTimingModel *)timingModel{

    _timingModel = timingModel;
    [self.timingLabel stop];
    [self.timingLabel startWithDate:timingModel.date];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
