//
//  TPCTableViewCell.h
//  Information
//
//  Created by qianfeng on 15/9/12.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"

@interface TPCTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickLabel;

- (void)showDataWithModel:(AppModel *)model;

@end
