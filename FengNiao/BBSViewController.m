//
//  BBSViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-3-2.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "BBSViewController.h"

@interface BBSViewController ()
@property(nonatomic,strong)NSArray*array1;
@property(nonatomic,strong)NSArray*array2;
@property(nonatomic,strong)NSArray*array3;
@property(nonatomic,strong)NSArray*array4;
@property(nonatomic,strong)NSArray*array5;
@property(nonatomic,strong)NSArray*array6;
@property(nonatomic,strong)NSArray*array7;

@end

@implementation BBSViewController

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
    
    //[self createNav];
    [self createButtons];
    [self createTableView];
    [self loadData];
    
    // Do any additional setup after loading the view.
}
-(void)loadData{
    
    self.dataArray=[NSMutableArray arrayWithCapacity:0];
    self.array1=@[@"热帖",@"精华帖",@"最新帖子",@"最新回复"];
    self.array2=@[@"人像",@"风光",@"纪实",@"旅行",@"人体",@"儿童",@"体育",@"建筑",@"生态",@"宠物"];
    self.array3=@[@"商业",@"女性视觉",@"新手",@"数码",@"黑白",@"实验",@"生活摄影",@"高校",@"手机",@"葡萄酒"];
    self.array4=@[@"交易警示",@"二手交易",@"器材维修"];
    self.array5=@[@"辽宁",@"深圳",@"天津",@"重庆",@"甘肃",@"哈尔滨",@"河南",@"武汉",@"江苏",@"江西",@"山西",@"大连",@"衡水",@"石家庄",@"沈阳",@"涿州",@"嘉兴",@"广州",@"吉林",@"山东",@"宁夏",@"西藏",@"贵州",@"北京",@"云南",@"青海",@"广西",@"内蒙古",@"福建",@"新疆",@"海南",@"湖南",@"安徽",@"杭州",@"秦皇岛",@"保定",@"廊坊",@"沧州",@"香港",@"陕西",@"德阳",@"珠海",@"上海",@"邯郸",@"大庆",@"青岛",@"成都",@"徐州",@"牡丹江"];
    self.array6=@[@"单反和镜头",@"大中画幅",@"便携数码",@"后期和软件",@"周边和附件",@"乐摄宝",@"百诺",@"佳能",@"尼康",@"索尼α",@"索尼Cyber－shot",@"适马",@"科漫",@"肯高",@"曼富图",@"腾龙",@"宾得",@"三星"];
    self.array7=@[@"活动区",@"网友服务",@"蜂鸟茶馆",@"论坛制度",@"常见问题"];
    self.dataArray=self.array1;
    [_tableView1 reloadData];
}


- (void)createTableView
{
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH/2,64,WIDTH/2,HEIGHT-64-49) style:UITableViewStylePlain];
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    
    //隐藏分割线
    //_tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView1];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"tableView1"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableView1"];
    }
    cell.textLabel.text=self.dataArray[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//设置行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(void)createButtons{
    NSArray*titleArray=@[@"全部论坛",@"题材作品区",@"特别摄影区",@"二手交易区",@"全国分站区",@"器材讨论区",@"论坛服务区"];
    NSArray*imageArray=@[@"bbs_icon_0.png",@"bbs_icon_1.png",@"bbs_icon_2.png",@"bbs_icon_3.png",@"bbs_icon_4.png",@"bbs_icon_5.png",@"bbs_icon_6.png"];
    for (int i=0; i<7; i++) {
        button=[ZCControl createButtonWithFrame:CGRectMake(0, 15+i*44, 170, 44) title:nil imageName:nil bgImageName:@"bbs_item_main_class_bg_normal.9.png" target:self method:@selector(buttonsClick:)];
        button.tag=100+i;
        [self.view addSubview:button];
        
        UILabel*label=[ZCControl createLabelWithFrame:CGRectMake(45, 15, 100, 20) font:15 text:titleArray[i]];
        label.textAlignment=NSTextAlignmentLeft;
        label.font=[UIFont boldSystemFontOfSize:15];
        [button addSubview:label];
        
        UIImageView*image=[ZCControl createImageViewFrame:CGRectMake(15, 15, 20, 20) imageName:imageArray[i]];
        [button addSubview:image];
    }
}
-(void)buttonsClick:(UIButton*)button{
    if (button.tag-100==0) {
        self.dataArray=self.array1;
    }
    if (button.tag-100==1) {
        self.dataArray=self.array2;
    }
    if (button.tag-100==2) {
        self.dataArray=self.array3;
    }
    if (button.tag-100==3) {
        self.dataArray=self.array4;
    }
    if (button.tag-100==4) {
        self.dataArray=self.array5;
    }
    if (button.tag-100==5) {
        self.dataArray=self.array6;
    }
    if (button.tag-100==6) {
        self.dataArray=self.array7;
    }
    [_tableView1 reloadData];
}

-(void)publishButtonClick:(UIButton*)button{
    
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

