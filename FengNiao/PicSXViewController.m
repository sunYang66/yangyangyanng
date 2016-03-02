//
//  PicSXViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-3-2.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "PicSXViewController.h"
#import "SCNavTabBarController.h"
#import "RXViewController.h"
#import "FGViewController.h"
#import "STViewController.h"
#import "XSViewController.h"
#import "CWViewController.h"
#import "SHViewController.h"
#import "JZViewController.h"
#import "DSViewController.h"
#import "QCViewController.h"

@interface PicSXViewController ()

@end

@implementation PicSXViewController

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
    RXViewController *vc1 = [[RXViewController alloc] init];
    vc1.title = @"人像";
    
    FGViewController *vc2 = [[FGViewController alloc] init];
    vc2.title = @"风光";
    
    STViewController *vc3 = [[STViewController alloc] init];
    vc3.title = @"生态";
    
    XSViewController *vc4 = [[XSViewController alloc] init];
    vc4.title = @"新手";
    
    CWViewController *vc5 = [[CWViewController alloc]init];
    vc5.title = @"宠物";
    
    SHViewController *vc6 = [[SHViewController alloc]init];
    vc6.title = @"生活";
    
    JZViewController *vc7 = [[JZViewController alloc]init];
    vc7.title = @"建筑";
    
    DSViewController *vc8 = [[DSViewController alloc]init];
    vc8.title = @"大师";
    
    QCViewController *vc9 = [[QCViewController alloc]init];
    vc9.title = @"器材";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8,vc9];
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
