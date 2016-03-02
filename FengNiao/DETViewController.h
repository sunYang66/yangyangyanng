//
//  DETViewController.h
//  FengNiao
//
//  Created by qianfeng on 15-3-2.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface DETViewController : UIViewController{
    UIScrollView *_scrollView;
    UIImageView *tempImageView;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic)int num;
@property(nonatomic,copy)NSString *_id;


@end
