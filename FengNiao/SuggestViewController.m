//
//  SuggestViewController.m
//  FengNiao
//
//  Created by qianfeng on 15-3-2.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import "SuggestViewController.h"

@interface SuggestViewController ()

@end

@implementation SuggestViewController

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
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(0, 0, 52, 34);
    [sendButton setBackgroundImage:[UIImage imageNamed:@"pageBG"] forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:sendButton];
    [sendButton addTarget:self action:@selector(sendSuggestMessage) forControlEvents:UIControlEventTouchUpInside];
    
    
    myTB = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, HEIGHT-44) style:UITableViewStyleGrouped];
    myTB.delegate = self;
    myTB.dataSource = self;
    [self.view addSubview:myTB];
    
    
}

-(void)sendSuggestMessage
{
    UITextField *suggestTF =(UITextField*)[self.view viewWithTag:1000];
    [suggestTF resignFirstResponder];
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (HEIGHT-20-44-30);
}


//表格定制
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    UITextField *suggestTF = [[UITextField alloc]initWithFrame:CGRectMake(10,0, 300, HEIGHT-20-44-30)];
    suggestTF.delegate = self;
    suggestTF.placeholder = @"请输入您的意见和建议...";
    suggestTF.tag = 1000;
    [cell.contentView addSubview:suggestTF];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField *suggestTF =(UITextField*)[self.view viewWithTag:1000];
    [suggestTF resignFirstResponder];
    return YES;
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
