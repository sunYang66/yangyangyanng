//
//  NewsViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-2-4.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "NewsViewController.h"
#import "SCNavTabBarController.h"
#import "JingxuanViewController.h"
#import "yingxiangViewController.h"
#import "LYViewController.h"
#import "QCViewController.h"
#import "SJViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createScrollView];
    
    // Do any additional setup after loading the view.
}
-(void)createScrollView
{
    JingxuanViewController *vc1 = [[JingxuanViewController alloc] init];
    vc1.title = @"精选";
    
    yingxiangViewController *vc2 = [[yingxiangViewController alloc] init];
    vc2.title = @"影像";
    
    LYViewController *vc3 = [[LYViewController alloc] init];
    vc3.title = @"旅游";
    
    QCViewController *vc4 = [[QCViewController alloc] init];
    vc4.title = @"汽车";
    
    SJViewController *vc5 = [[SJViewController alloc]init];
    vc5.title = @"手机";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[vc1,vc2,vc3,vc4,vc5];
    navTabBarController.showArrowButton = YES;
    [navTabBarController addParentController:self];
    
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
