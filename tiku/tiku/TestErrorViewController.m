//
//  TestErrorViewController.m
//  Accountant
//
//  Created by aaa on 2017/3/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestErrorViewController.h"
#import "UIMacro.h"
#import "TestManager.h"
#import "SVProgressHUD.h"
#import "YUFoldingTableView.h"
#import "MJRefresh.h"
#import "CommonMacro.h"
#import "SectionListTableViewCell.h"
#import "TestChapterQuestionViewController.h"
#import "TestErrorListTableViewCell.h"

@interface TestErrorViewController ()<UITableViewDelegate,UITableViewDataSource,TestModule_ErrorInfoProtocol,TestModule_ErrorQuestionProtocol,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView        *tableView;
@property (nonatomic,strong) NSArray            *array;

@property (nonatomic,assign) int                                     selectSection;
@property (nonatomic,assign) int                                     selectRow;

@end

@implementation TestErrorViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationViewSetup];
    [self contentViewSetup];
    // Do any additional setup after loading the view.
    [self requestErrorList];
}

- (void)requestErrorList
{
    [SVProgressHUD show];
    [[TestManager sharedManager] didRequestTestErrorInfoWithCategoryId:self.cateId andNotifiedObject:self];
}

- (void)requestErrorQuestionsWithId:(int)chapterId
{
    [SVProgressHUD show];
    [[TestManager sharedManager] didRequestTestErrorQuestionWithSectionId:chapterId andNotifiedObject:self];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer
                                      *)gestureRecognizer{
    return YES; //YES：允许右滑返回  NO：禁止右滑返回
}

- (void)addHistory
{
    NSDictionary *dic = [self.array objectAtIndex:self.selectRow];
    NSDictionary *d = @{kTestAddHistoryType:@(5),
                        kTestChapterId:[dic objectForKey:kTestChapterId],
                        kTestSectionId:@(0),
                        kTestSimulateId:@(0)};
    [[TestManager sharedManager] didRequestAddTestHistoryWithInfo:d];
}

#pragma mark - delegate func

- (void)didReqeustErrorInfoSuccess
{
    [SVProgressHUD dismiss];
    [self.tableView.mj_header endRefreshing];
    self.array = [[TestManager sharedManager] getErrorInfoArray];
    [self.tableView reloadData];
}

- (void)didReqeustErrorInfoFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestErrorQuestionSuccess
{
    [SVProgressHUD dismiss];
    [self addHistory];
    TestChapterQuestionViewController *vc = [[TestChapterQuestionViewController alloc] init];
    vc.questionType = TestQuestionTypeError;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didRequestErrorQuestionFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - ui
- (void)navigationViewSetup
{
    self.navigationItem.title = @"易错题";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)contentViewSetup
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight) style:UITableViewStylePlain];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestErrorList)];
    [self.view addSubview:self.tableView];
}

#pragma mark - table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectRow = indexPath.row;
    NSDictionary *dic = [self.array objectAtIndex:indexPath.row];
    [self requestErrorQuestionsWithId:[[dic objectForKey:kTestChapterId] intValue]];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestErrorListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"errorQuestionCell"];
    if (cell == nil) {
        cell = [[TestErrorListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"errorQuestionCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = [self.array objectAtIndex:indexPath.row];
    [cell resetContentWithInfo:dic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
