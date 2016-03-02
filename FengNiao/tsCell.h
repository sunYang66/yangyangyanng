//
//  tsCell.h
//  FengNiao
//
//  Created by qianfeng on 15-1-30.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jingxuan.h"

@interface tsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;

-(void)configModel:(Jingxuan*)model;
@end
