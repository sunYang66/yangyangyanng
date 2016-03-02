//
//  JingxuanViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-1-26.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "JingxuanViewController.h"
#import "Jingxuan.h"
#import "MJRefresh.h"
#import "JXSmallCell.h"
#import "UIImageView+WebCache.h"
#import "MessageViewController.h"

@interface JingxuanViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    MJRefreshHeaderView*header;
    MJRefreshFooterView*footer;
    UITableView * _tableView;
    NSMutableArray*arraySc;
    UIScrollView*sc;
    UIPageControl*pageControl;
    //记录是哪页
    __block int page;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
//@property(nonatomic,copy)NSString*UrlStr;
@end

@implementation JingxuanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    page = 1;
    [self createTabelView];
    //self.UrlStr = @"http://api.fengniao.com/app_ipad/news_jingxuan.php?appImei=99000505856649&osType=Android&osVersion=4.1.1&page=%d";
    [self createRefresh];
    //进入后开始下拉刷新
    [header beginRefreshing];
}

- (void)createRefresh{
    //下拉刷新，上拉加载
    header=[MJRefreshHeaderView header];
    header.scrollView=_tableView;
    header.beginRefreshingBlock=^(MJRefreshBaseView*view){
         page=1;
        [self loadData];
    };
    
    footer=[MJRefreshFooterView footer];
    footer.scrollView=_tableView;
    footer.beginRefreshingBlock=^(MJRefreshBaseView*view){
        page++;
        [self loadData];
        
    };
}
- (void)loadData{
    self.UrlStr = @"http://api.fengniao.com/app_ipad/news_jingxuan.php?appImei=99000505856649&osType=Android&osVersion=4.1.1&page=%d";
    NSString *newUrtStr = [NSString stringWithFormat:self.UrlStr,page];
    newUrtStr = [newUrtStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HttpRequestBlock *request = [[HttpRequestBlock alloc]initWithUrlPath:newUrtStr Block:^(BOOL isSucceed, HttpRequestBlock *http) {
        //获得数据，建立模型
        if (isSucceed) {
            NSArray*array=http.dataDic[@"160120"];
            if (page==1) {
                self.dataArray = [NSMutableArray arrayWithCapacity:0];
            }
            //建立模型
            for (NSDictionary *dic in array) {
                Jingxuan *model = [[Jingxuan alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                //追加数据
                [self.dataArray addObject:model];
            }
//            //追加完成后刷新数据
            [_tableView reloadData];
//            //收回下拉或者上拉的界面
//            
//            
            if (page==1) {
                [header endRefreshing];
            }else{
                [footer endRefreshing];
            }

        }
        
    }];
}
- (void)createTabelView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-130) style:UITableViewStyleGrouped]  ;
    _tableView.rowHeight = 70;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JXSmallCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JXSmallCell" owner:self options:nil]lastObject];
    }
    //读取数据源
    Jingxuan *model = self.dataArray[indexPath.row];
    [cell configModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HttpRequestBlock *block = [[HttpRequestBlock alloc]initWithUrlPath:@"http://api.fengniao.com/app_ipad//focus_pic.php?appImei=99000505856649&osType=Android&osVersion=4.1.1&mid=19928" Block:^(BOOL isSucceed, HttpRequestBlock *http) {
        if (isSucceed) {
            NSArray *array = http.dataArray;
            arraySc = [NSMutableArray arrayWithArray:array];
        }
    }];
    if (sc) {
        [sc removeObserver:self forKeyPath:@"contentOffset"];

    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    //view.backgroundColor = [UIColor redColor];
    sc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    sc.contentOffset=CGPointMake(0, 0);
    sc.delegate=self;
    sc.bounces=NO;
    sc.showsHorizontalScrollIndicator=NO;
    sc.pagingEnabled=YES;
    sc.contentSize=CGSizeMake((arraySc.count)*320, 150);
    [view addSubview:sc];
    
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(250, 130, 40, 20)];
    pageControl.numberOfPages=arraySc.count;
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor=[UIColor greenColor];
    [view addSubview:pageControl];
    
    
    [sc addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
    for (int i=0; i<arraySc.count; i++) {
        UIImageView*imageViewSc=[ZCControl createImageViewFrame:CGRectMake(i*320, 0, 320, 130) imageName:nil];
        imageViewSc.tag=100+i;
        imageViewSc.userInteractionEnabled=YES;
        [imageViewSc sd_setImageWithURL:[NSURL URLWithString:arraySc[i][@"pic_src"]]];
        [sc addSubview:imageViewSc];
        UIImageView *bgimageView=[ZCControl createImageViewFrame:CGRectMake(i*320, 130, 320, 20) imageName:nil];
        
        bgimageView.backgroundColor=[UIColor blackColor];
        
        [sc addSubview:bgimageView];
        
        UILabel*titleLabel=[ZCControl createLabelWithFrame:CGRectMake(5, 0, 320, 20) font:10 text:nil];
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.text=arraySc[i][@"title"];
        [bgimageView addSubview:titleLabel];
        
    }
    return view;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    int x =sc.contentOffset.x/320;
    pageControl.currentPage=x;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Jingxuan *model = self.dataArray[indexPath.row];
    MessageViewController*vc=[[MessageViewController alloc]init];
    vc.ID=model.doc_id;
    vc.hidesBottomBarWhenPushed=NO;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
