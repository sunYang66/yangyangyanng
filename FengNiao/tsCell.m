//
//  tsCell.m
//  FengNiao
//
//  Created by qianfeng on 15-1-30.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "tsCell.h"
#import "UIImageView+WebCache.h"
@implementation tsCell

- (void)awakeFromNib
{
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)configModel:(Jingxuan *)model{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.title.text = model.title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
