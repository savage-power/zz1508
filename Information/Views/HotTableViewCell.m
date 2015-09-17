//
//  HotTableViewCell.m
//  PlamInformation
//
//  Created by qianfeng on 15/9/8.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "HotTableViewCell.h"
@implementation HotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showDataWithModel:(AppModel *)model {
        [self.hotImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",model.host,model.dir,model.filepath,model.filename]]placeholderImage:[UIImage imageNamed:@"card_bg"]];
        
        self.titleLabel.text = model.title;
        
        self.authorLabel.text = [NSString stringWithFormat:@"作者 %@",model.author];
        
        self.clickLabel.text = [NSString stringWithFormat:@"点击 %@", model.clickNum];
    }



@end
