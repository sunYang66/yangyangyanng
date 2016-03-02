//
//  AboutViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-3-2.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "AboutViewController.h"
#import "SettingViewController.h"
@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createNav];
    [self createView];
    // Do any additional setup after loading the view.
}
-(void)createView{
    UIImageView*imageView=[ZCControl createImageViewFrame:CGRectMake(80, 40, self.view.frame.size.width-160, 100) imageName:@"set_img_about.png"];
    [self.view addSubview:imageView];
    UILabel*titleLabel=[ZCControl createLabelWithFrame:CGRectMake(10, 170, self.view.frame.size.width-20, 30) font:15 text:@"传承影像文化 缔造商业价值"];
    titleLabel.font=[UIFont boldSystemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    UILabel*detailLable=[ZCControl createLabelWithFrame:CGRectMake(10, 200, self.view.frame.size.width-20, 100) font:12 text:@"蜂鸟网www.fengniao.com中国第一影像门户。这里聚集着最具时尚、活力的摄影爱好者，这里融合了最实用的摄影技巧，最具个性的摄影作品，最新的摄影器材采购资讯；涉及生活摄影、旅游摄影、风光摄影，是热爱摄影的朋友们展示作品，交流技巧，分享心得的专业平台，是引领摄影行业的前沿媒体。"];
    detailLable.textAlignment=0;
    detailLable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:detailLable];
    
}
-(void)createNav{
    self.navigationController.navigationBar.translucent=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    imageView.image=[UIImage imageNamed:@"news_bg_bottom.png"];
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    UILabel*titleLabel=[ZCControl createLabelWithFrame:CGRectMake(100, 0, 80, 44) font:15 text:@"关于我们"];
    titleLabel.font=[UIFont boldSystemFontOfSize:20];
    titleLabel.textColor=[UIColor whiteColor];
    [imageView addSubview:titleLabel];
    UIButton*backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(10, 7, 60, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back_normal.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back_focus.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:backButton];
    
}
-(void)backButtonClick:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
