//
//  JXSmallCell.h
//  FengNiao
//
//  Created by qianfeng on 15-1-26.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jingxuan.h"

@interface JXSmallCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *author;

-(void)configModel:(Jingxuan*)model;
@end
