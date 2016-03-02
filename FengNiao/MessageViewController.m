//
//  MessageViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-1-29.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "MessageViewController.h"


@interface MessageViewController (){
    UIWebView *_webView;
}

@end

@implementation MessageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    // Do any additional setup after loading the view.
}

- (void)createView{
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    NSURLRequest*request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.fengniao.com/app_ipad/news_iphone_doc_v2.php?docid=%@&isPad=2",self.ID]]];
    
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
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
