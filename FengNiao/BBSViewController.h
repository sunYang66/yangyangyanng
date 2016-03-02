//
//  BBSViewController.h
//  FengNiao
//
//  Created by qianfeng on 15-3-2.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView1;
    UIButton*button;
}

@property(nonatomic,strong)NSArray*dataArray;

@end
