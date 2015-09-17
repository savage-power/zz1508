//
//  TPCTableViewCell.m
//  Information
//
//  Created by qianfeng on 15/9/12.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "TPCTableViewCell.h"

@implementation TPCTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showDataWithModel:(AppModel *)model {
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",model.host,model.dir,model.filepath,model.filename]] placeholderImage:[UIImage imageNamed:@"card_bg"]];
    self.titleLabel.text = model.title;
    self.briefLabel.text = model.brief;
    self.authorLabel.text = [NSString stringWithFormat:@"作者 %@ 来源 %@",model.author,model.source];
    
    self.clickLabel.text = [NSString stringWithFormat:@"点击 %@", model.clickNum];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
