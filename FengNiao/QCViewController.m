//
//  QCViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-3-2.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "QCViewController.h"
#import "MJRefresh.h"
#import "tsCell.h"
#import "Jingxuan.h"
#import "UIImageView+WebCache.h"
@interface QCViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>{
    MJRefreshHeaderView*header;
    MJRefreshFooterView*footer;
    UICollectionView* _collectionView;
    UIScrollView*sc;
    UIPageControl*pageControl;
    //记录是哪页
    __block int page;
}


@end

@implementation QCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    page = 1;
    self.urlStr = @"http://api.fengniao.com/app_ipad/pic_zutu_list.php?appImei=99000505856649&osType=Android&osVersion=4.1.1&cid=296&page=%d";
    [self createCollectionView];
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
