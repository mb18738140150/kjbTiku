//
//  TestSimulateViewController.m
//  Accountant
//
//  Created by aaa on 2017/3/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestSimulateViewController.h"
#import "UIMacro.h"
#import "TestManager.h"
#import "SVProgressHUD.h"
#import "YUFoldingTableView.h"
#import "MJRefresh.h"
#import "CommonMacro.h"
#import "SectionListTableViewCell.h"
#import "TestChapterQuestionViewController.h"
#import "TestSimulateQuestionViewController.h"
#import "TestSimulateListTableViewCell.h"

@interface TestSimulateViewController ()<UITableViewDelegate,UITableViewDataSource,TestModule_SimulateInfoProtocol,TestModule_SimulateQuestionProtocol,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView                            *simulateTableView;
@property (nonatomic,strong) NSArray                                *testSimulateInfoArray;
@property (nonatomic,assign) int                                     selectedRow;

@end

@implementation TestSimulateViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationViewSetup];
    [self tableViewsSetup];
    [self requestSimulateInfo];
}

- (void)requestSimulateInfo
{
    [SVProgressHUD show];
    [[TestManager sharedManager] didRequestTestSimulateInfoWithCategoryId:self.cateId andNotifiedObject:self];
}

- (void)requestSimulateQuestionWithId:(int)testId
{
    [SVProgressHUD show];
    [[TestManager sharedManager] didRequestTestSimulateQuestionWithTestId:testId andNotifiedObject:self];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer
                                      *)gestureRecognizer{
    return YES; //YES：允许右滑返回  NO：禁止右滑返回
}

- (void)addHistory
{
    NSDictionary *dic = [self.testSimulateInfoArray objectAtIndex:self.selectedRow];
    NSDictionary *d = @{kTestAddHistoryType:@(2),
                        kTestChapterId:@(0),
                        kTestSectionId:@(0),
                        kTestSimulateId:[dic objectForKey:kTestSimulateId]};
    [[TestManager sharedManager] didRequestAddTestHistoryWithInfo:d];
}

#pragma mark - delegate
- (void)didRequestSimulateInfoSuccess
{
    [SVProgressHUD dismiss];
    [self.simulateTableView.mj_header endRefreshing];
    self.testSimulateInfoArray = [[TestManager sharedManager] getSimulateInfoArray];
    [self.simulateTableView reloadData];
}

- (void)didRequestSimulateInfoFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [self.simulateTableView.mj_header endRefreshing];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestSimulateQuestionSuccess
{
    [SVProgressHUD dismiss];
    [self addHistory];
    TestSimulateQuestionViewController *vc = [[TestSimulateQuestionViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didRequestSimulateQuestionFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testSimulateInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestSimulateListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simulateCell"];
    if (cell == nil) {
        cell = [[TestSimulateListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simulateCell"];
    }
    
    NSDictionary *dic = [self.testSimulateInfoArray objectAtIndex:indexPath.row];
    [cell resetContentWithInfo:dic];
//    NSLog(@"%@",[dic objectForKey:kTestSimulateName]);
//    cell.textLabel.text = [dic objectForKey:kTestSimulateName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.testSimulateInfoArray objectAtIndex:indexPath.row];
    self.selectedRow = (int)indexPath.row;
    [self requestSimulateQuestionWithId:[[dic objectForKey:kTestSimulateId] intValue]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - ui

- (void)navigationViewSetup
{
    self.navigationItem.title = @"模拟练习";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)tableViewsSetup
{
    self.simulateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight) style:UITableViewStylePlain];
    self.simulateTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestSimulateInfo)];
    self.simulateTableView.delegate = self;
    self.simulateTableView.dataSource = self;
    [self.view addSubview:self.simulateTableView];
}
@end
