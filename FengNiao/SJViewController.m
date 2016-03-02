//
//  SJViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-2-4.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "SJViewController.h"
#import "MJRefresh.h"
#import "tsCell.h"
#import "Jingxuan.h"
#import "UIImageView+WebCache.h"
#import "MessageViewController.h"

@interface SJViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>{
    MJRefreshHeaderView*header;
    MJRefreshFooterView*footer;
    NSMutableArray*arraySc;
    UICollectionView* _collectionView;
    UIScrollView*sc;
    UIPageControl*pageControl;
    //记录是哪页
    __block int page;
}


@end

@implementation SJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    page = 1;
    
    [self createCollectionView];
    [self createView];
    [self createRefresh];
    //进入后开始下拉刷新
    [header beginRefreshing];
    
    // Do any additional setup after loading the view.
}
- (void)createRefresh{
    //下拉刷新，上拉加载
    header=[MJRefreshHeaderView header];
    header.scrollView=_collectionView;
    header.beginRefreshingBlock=^(MJRefreshBaseView*view){
        page=1;
        [self loadData];
    };
    
    footer=[MJRefreshFooterView footer];
    footer.scrollView=_collectionView;
    footer.beginRefreshingBlock=^(MJRefreshBaseView*view){
        page++;
        [self loadData];
        
    };
}
- (void)loadData{
    self.urlStr = @"http://api.fengniao.com/app_ipad/news_list.php?appImei=99000505856649&osType=Android&osVersion=4.1.1&cid=340&page=%d";
    NSString *newUrtStr = [NSString stringWithFormat:self.urlStr,page];
    newUrtStr = [newUrtStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HttpRequestBlock *request = [[HttpRequestBlock alloc]initWithUrlPath:newUrtStr Block:^(BOOL isSucceed, HttpRequestBlock *http) {
        //获得数据，建立模型
        if (isSucceed) {
            NSArray*array=http.dataDic[@"list"];
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
            //追加完成后刷新数据
            [_collectionView reloadData];
            //收回下拉或者上拉的界面
            if (page==1) {
                [header endRefreshing];
            }else{
                [footer endRefreshing];
            }
            
        }
        
    }];
}
- (void)createCollectionView{
    //布局
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    //一项宽高
    float width = 120;
    float height = 120;
    float widthSpace = (WIDTH - 60 * 3) / 5;
    layout.itemSize = CGSizeMake(width, height);
    //行间距
    layout.minimumLineSpacing = 10;
    //方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //四周空白区域
    layout.sectionInset = UIEdgeInsetsMake(widthSpace, widthSpace, widthSpace, widthSpace);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"tsCell" bundle:nil] forCellWithReuseIdentifier:@"ID"];
    
}
//几组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//几项
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    tsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    Jingxuan *model = self.dataArray[indexPath.row];
    [cell configModel:model];
    
    return cell;
}


- (void)createView{
    HttpRequestBlock *block = [[HttpRequestBlock alloc]initWithUrlPath:@"http://api.fengniao.com/app_ipad//focus_pic.php?appImei=99000505856649&osType=Android&osVersion=4.1.1&mid=19934" Block:^(BOOL isSucceed, HttpRequestBlock *http) {
        if (isSucceed) {
            NSArray *array = http.dataArray;
            arraySc = [NSMutableArray arrayWithArray:array];
        }
    }];
    
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
    [_collectionView addSubview:view];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    int x =sc.contentOffset.x/320;
    pageControl.currentPage=x;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Jingxuan *model = self.dataArray[indexPath.row];
    MessageViewController*vc=[[MessageViewController alloc]init];
    vc.ID=model.doc_id;
    vc.hidesBottomBarWhenPushed=NO;
    [self.navigationController pushViewController:vc animated:YES];
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
