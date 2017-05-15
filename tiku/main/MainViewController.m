//
//  MainViewController.m
//  tiku
//
//  Created by aaa on 2017/4/26.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "MainheadView.h"

#define kMaintableviewcellId @"MainTableViewCellID"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)MainheadView * mainheadView;

@property (nonatomic, strong)NSArray * iconArr;
@property (nonatomic, strong)NSArray *titleArr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleArr = @[@"收藏夹",@"错题夹",@"已购买的课程",@"我的消息",@"意见反馈",@"设置"];
    self.iconArr = @[@"main_icon1",@"main_icon2",@"main_icon3",@"main_icon4",@"main_icon5",@"main_icon6"];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    UINavigationBar * bar = self.navigationController.navigationBar;
    [bar setShadowImage:[UIImage imageNamed:@"tm"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tm"] forBarMetrics:UIBarMetricsDefault];
    
    self.mainheadView = [[MainheadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 222)];
    [self.mainheadView reset];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight + 64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:kMaintableviewcellId];
    self.tableview.tableHeaderView = self.mainheadView;
    self.tableview.backgroundColor = kBackgroundGrayColor;
    self.tableview.bounces = NO;
    [self.view addSubview:self.tableview];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    UINavigationBar * bar = self.navigationController.navigationBar;
    [bar setShadowImage:[UIImage imageNamed:@"tm"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tm"] forBarMetrics:UIBarMetricsDefault];
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x12B7F5)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMaintableviewcellId forIndexPath:indexPath];
    
    [cell resetWithName:self.titleArr[indexPath.row] icon:self.iconArr[indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.mainheadView = [[MainheadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 222)];
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 222;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
