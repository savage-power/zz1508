//
//  HotTableViewCell.h
//  PlamInformation
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
@interface HotTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hotImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickLabel;


- (void)showDataWithModel:(AppModel *)model;
@end
