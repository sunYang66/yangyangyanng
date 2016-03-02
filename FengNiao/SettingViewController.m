//
//  SettingViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-2-2.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"
#import "SuggestViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createButtons];
    // Do any additional setup after loading the view.
}

-(void)createButtons{
    NSArray*titleArray = @[@"注册／登录蜂鸟",@"分享账号管理",@"我的论坛",@"个人收藏",@"清除应用缓存",@"建议反馈",@"关于我们"];
    NSArray*imageArray1 = @[@"set_icon_account.png",@"set_icon_weibo.png",@"set_icon_mybbs.png",@"set_icon_favorite.png",@"set_icon_clear_cache.png",@"set_icon_auto_image.png",@"set_icon_feedback.png",@"set_icon_about.png"];
    //NSArray*imageArray2 = @[@"set_item_arrow.png",@"set_item_arrow.png",@"set_item_arrow.png",@"set_item_arrow.png",@"set_item_arrow.png",@"set_switch_on.png",@"set_item_arrow.png",@"set_item_arrow.png"];
    for (int i=0; i<7; i++) {
        UIImage*bgImage = [UIImage imageNamed:@"set_bg_item_normal.9.png"];
        bgImage = [bgImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIButton*button = [ZCControl createButtonWithFrame:CGRectMake(0, 64+i*49, 320, 60) title:nil imageName:nil bgImageName:@"set_bg_item_normal.9.png" target:self method:@selector(buttonsClick:)];
        button.tag=100+i;
        [self.view addSubview:button];
        
        UILabel*label = [ZCControl createLabelWithFrame:CGRectMake(40, 15, 150, 20) font:15 text:titleArray[i]];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15];
        [button addSubview:label];
        
        UIImageView*image1 = [ZCControl createImageViewFrame:CGRectMake(15, 20, 15, 15) imageName:imageArray1[i]];
        [button addSubview:image1];
        
//        if (button.tag==105) {
//            UIImageView*image=[ZCControl createImageViewFrame:CGRectMake(250, 20, 40, 15) imageName:@"set_switch_on.png"];
//            [button addSubview:image];
//        }else{
//            UIImageView*image2=[ZCControl createImageViewFrame:CGRectMake(280, 20, 10, 15) imageName:@"set_item_arrow.png"];
//            [button addSubview:image2];
//        }
    }
    
}
-(void)buttonsClick:(UIButton*)button{
    if (button.tag==100) {
        
    }
    if (button.tag==104) {
        UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:@"缓存已清除" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [myAlert show];
    }
    if (button.tag==105) {
        SuggestViewController *vc = [[SuggestViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag==106) {
        AboutViewController *vc = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
