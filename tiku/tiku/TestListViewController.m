//
//  TestListViewController.m
//  Accountant
//
//  Created by aaa on 2017/3/18.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestListViewController.h"
#import "UIMacro.h"
#import "TestManager.h"
#import "SVProgressHUD.h"
#import "YUFoldingTableView.h"
#import "MJRefresh.h"
#import "CommonMacro.h"
#import "SectionListTableViewCell.h"
#import "TestChapterQuestionViewController.h"

#define kHeaderViewHeight 45

@interface TestListViewController ()<YUFoldingTableViewDelegate,TestModule_ChapterInfoProtocol,TestModule_SectionQuestionProtocol,UIGestureRecognizerDelegate>


@property (nonatomic,strong) YUFoldingTableView                     *chapterTableView;

@property (nonatomic,strong) NSArray                                *testChapterInfoArray;

@property (nonatomic,assign) int                                     selectSection;
@property (nonatomic,assign) int                                     selectRow;

@end

@implementation TestListViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationViewSetup];
    [self tableViewsSetup];
    if (self.listType == TestListTypeChapterTest) {
        [self requesChapterPractice];
    }
    
}

- (void)requesChapterPractice
{
    [SVProgressHUD show];
    [[TestManager sharedManager] didRequesTestChapterInfoWithCategoryId:self.cateId andNotifiedObject:self];
}

- (void)requestSectionQuestionsWithSectionId:(int)sectionId
{
    [SVProgressHUD show]; 
    [[TestManager sharedManager] didRequestTestSectionQuestionWithSection:sectionId andNotifiedObject:self];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer
                                      *)gestureRecognizer{
    return YES; //YES：允许右滑返回  NO：禁止右滑返回
}

- (void)addHistory
{
    NSDictionary *dic = [self.testChapterInfoArray objectAtIndex:self.selectSection];
    NSArray *array = [dic objectForKey:kTestChapterSectionArray];
    NSDictionary *secDic = [array objectAtIndex:self.selectRow];
    NSDictionary *d = @{kTestAddHistoryType:@(1),
                        kTestChapterId:@([[dic objectForKey:kTestChapterId] intValue]),
                        kTestSectionId:@([[secDic objectForKey:kTestSectionId] intValue]),
                        kTestSimulateId:@(0)};
    [[TestManager sharedManager] didRequestAddTestHistoryWithInfo:d];
}

#pragma mark - test delegate
- (void)didRequestChapterInfoSuccess
{
    [SVProgressHUD dismiss];
    [self.chapterTableView.mj_header endRefreshing];
    self.testChapterInfoArray = [[TestManager sharedManager] getChapterInfoArray];
    
    [self.chapterTableView reloadData];
}

- (void)didRequestChapterInfoFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [self.chapterTableView.mj_header endRefreshing];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestSectionQuestionSuccess
{
    [SVProgressHUD dismiss];
    TestChapterQuestionViewController *vc = [[TestChapterQuestionViewController alloc] init];
    vc.questionType = TestQuestionTypeChapter;
    [self addHistory];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didRequestSectionQuestionFailed:(NSString *)failedInfo
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
    if (self.listType == TestListTypeChapterTest) {
        self.navigationItem.title = @"章节练习";
    }
    if (self.listType == TestListTypeError) {
        self.navigationItem.title = @"易错题";
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)tableViewsSetup
{
    self.chapterTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight)];
    self.chapterTableView.foldingDelegate = self;
    self.chapterTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requesChapterPractice)];
    [self.view addSubview:self.chapterTableView];
}

#pragma mark - table delegate
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return YUFoldingSectionHeaderArrowPositionLeft;
}
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return self.testChapterInfoArray.count;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    NSDictionary *dic = [self.testChapterInfoArray objectAtIndex:section];
    NSArray *array = [dic objectForKey:kTestChapterSectionArray];
    return array.count;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = [self.testChapterInfoArray objectAtIndex:section];
    return [dic objectForKey:kTestChapterName];
}
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"testChapterCell";
    SectionListTableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[SectionListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = [self.testChapterInfoArray objectAtIndex:indexPath.section];
    NSArray *array = [dic objectForKey:kTestChapterSectionArray];
    NSDictionary *secDic = [array objectAtIndex:indexPath.row];
//    cell.textLabel.text = [secDic objectForKey:kTestSectionName];
    [cell resetTitleStr:secDic];
    
    return cell;
}
- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectSection = (int)indexPath.section;
    self.selectRow = (int)indexPath.row;
    NSDictionary *dic = [self.testChapterInfoArray objectAtIndex:indexPath.section];
    NSArray *array = [dic objectForKey:kTestChapterSectionArray];
    NSDictionary *secDic = [array objectAtIndex:indexPath.row];
    [self requestSectionQuestionsWithSectionId:[[secDic objectForKey:kTestSectionId] intValue]];
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
