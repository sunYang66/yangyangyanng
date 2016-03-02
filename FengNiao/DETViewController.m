//
//  DETViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-3-2.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "DETViewController.h"

@interface DETViewController (){
    UIImageView *iconImageView;
    UILabel *titleLabel;
}

@end

@implementation DETViewController

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
    [self loadData];
}


- (void)loadData{
    //4086
    // NSString *urlStr = [NSString stringWithFormat:@"http://ktx.cms.palmtrends.com/api_v2.php?action=picture&sa=&uid=10067567&mobile=iphone5&offset=0&count=15&gid=%@&moblie=iphone5&e=40dab97d773e7860febfc897c04824e2&uid=10067567&pid=10053&mobile=iphone5&platform=i",self._id];
    HttpRequestBlock*block=[[HttpRequestBlock alloc]initWithUrlPath:@"http://api.fengniao.com/app_ipad/pic_bbs_detail.php?id=4080700&fid=101" Block:^(BOOL  isSucceed, HttpRequestBlock *http) {
        
        if(isSucceed  ){
            self.dataArray=[NSMutableArray arrayWithArray:http.dataArray];
            
            [self refreshViewl];
        }
    }];
}

- (void)refreshViewl{
    for (int i=0; i<self.dataArray.count; i++) {
        //读取数据源
        NSDictionary *dic1 = self.dataArray[i];
        NSDictionary *dic = dic1[@"pic"];
        NSString *urlStr = dic[@"gq"];
        
        iconImageView = [ZCControl createImageViewFrame:CGRectMake(i*WIDTH, 30, WIDTH, HEIGHT-64-49) imageName:nil];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"ViewBackground.png"]];
        
        titleLabel = [ZCControl createLabelWithFrame:CGRectMake(10, 300, WIDTH, 44) font:20 text:nil];
        titleLabel.text = dic1[@"doc_title"];
        [iconImageView addSubview:titleLabel];
        
        //        desLabel = [ZCControl createLabelWithFrame:CGRectMake(5, 330, WIDTH, 60) font:12 text:nil];
        //        desLabel.text = dic[@"pic_datil"];
        //        [iconImageView addSubview:desLabel];
        
        [_scrollView addSubview:iconImageView];
    }
}
- (void)createScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT-100)];
    
    _scrollView.contentSize = CGSizeMake(WIDTH*self.dataArray.count, HEIGHT-64);
    if (_num) {
        _scrollView.contentOffset = CGPointMake(WIDTH*_num, 0);
    }
    //关闭自适配
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
}

@end
