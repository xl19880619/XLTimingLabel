//
//  XLTimingTableViewCell.h
//  XLTimingLabel
//
//  Created by 谢小雷 on 16/2/23.
//  Copyright © 2016年 *. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XLTimingLabel/XLTimingLabel.h>
@class XLTimingModel;
@interface XLTimingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet XLTimingLabel *timingLabel;
@property (strong, nonatomic) XLTimingModel *timingModel
;
@end
