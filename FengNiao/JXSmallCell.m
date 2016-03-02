//
//  JXSmallCell.m
//  FengNiao
//
//  Created by qianfeng on 15-1-26.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "JXSmallCell.h"
#import "UIImageView+WebCache.h"

@implementation JXSmallCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configModel:(Jingxuan *)model{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.name.text = model.title;
    NSString *str = [model.date componentsSeparatedByString:@" "][0];
    self.date.text = str;
    self.author.text = model.author;
}
@end
