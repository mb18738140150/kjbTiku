//
//  CommunityViewController.m
//  tiku
//
//  Created by aaa on 2017/4/26.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityTableViewCell.h"


@interface CommunityViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,assign) BOOL                            isLoadingMore;

@property (nonatomic,strong) UITableView                    *contentTableView;

@property (nonatomic,strong) NSArray                        *questionsInfos;

@property (nonatomic,strong) UIImageView                    *publishImageView;



@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self navigationViewSetup];
    
    [self contentViewSetup];
    
//    [self doStartQuestionRequest];
    
    self.isLoadingMore = NO;
}

#pragma mark - request func

- (void)doStartQuestionRequest
{
    [SVProgressHUD show];
//    [[QuestionManager sharedManager] didCurrentPageQuestionRequestWithNotifiedObject:self];
}

- (void)doResetQuestionRequest
{
//    [[QuestionManager sharedManager] resetQuestionRequestConfig];
//    [[QuestionManager sharedManager] didCurrentPageQuestionRequestWithNotifiedObject:self];
}

- (void)doNextPageQuestionRequest
{
    if (!self.isLoadingMore) {
//        [[QuestionManager sharedManager] didNextPageQuestionRequestWithNotifiedObject:self];
    }
}

- (void)pushQuestionDetailWithQuestionId:(int)questionId
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
//    QuestionDetailViewController *detailController = [[QuestionDetailViewController alloc] init];
//    detailController.questionId = questionId;
//    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)publishQuestion
{
//    PublishQuestionViewController *vc = [[PublishQuestionViewController alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ui setup

- (void)navigationViewSetup
{
    self.navigationItem.title = @"交流";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonNavigationBarTextColor,NSFontAttributeName:[UIFont systemFontOfSize:17]};
}

- (void)contentViewSetup
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight) style:UITableViewStylePlain];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.separatorStyle= UITableViewCellSelectionStyleNone;
    
//    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
//    self.contentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
    
    [self.view addSubview:self.contentTableView];
    
    self.publishImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 70, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight - 70, 50, 50)];
    self.publishImageView.backgroundColor = [UIColor whiteColor];
    self.publishImageView.layer.cornerRadius = 30;
    self.publishImageView.image = [UIImage imageNamed:@"community_btn"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(publishQuestion)];
    self.publishImageView.userInteractionEnabled = YES;
    [self.publishImageView addGestureRecognizer:tap];
    [self.view addSubview:self.publishImageView];
}

#pragma mark - question delegate
- (void)didQuestionRequestSuccessed
{
    self.isLoadingMore = NO;
//    self.questionsInfos = [[QuestionManager sharedManager] getQuestionsInfos];
    [SVProgressHUD dismiss];
    [self.contentTableView reloadData];
    [self.contentTableView.mj_header endRefreshing];
    [self.contentTableView.mj_footer endRefreshing];
//    if ([[QuestionManager sharedManager] isLoadMax]) {
//        [self.contentTableView.mj_footer endRefreshingWithNoMoreData];
//    }
}

- (void)didQuestionRequestFailed:(NSString *)failedInfo
{
    self.isLoadingMore = NO;
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:@"网络连接失败，请稍后再试"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    });
    [self.contentTableView.mj_header endRefreshing];
    [self.contentTableView.mj_footer endRefreshing];
}

#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    CGFloat maxHeight = 80;
    UIFont *font = kMainFont;
    CGFloat contentHeight = [UIUtility getHeightWithText:[[self.questionsInfos objectAtIndex:indexPath.row] objectForKey:kQuestionContent] font:font width:kScreenWidth - 40];
    if (contentHeight > maxHeight) {
        height = 80;
    }else{
        height = contentHeight;
    }
    
    NSArray *imgs = [[self.questionsInfos objectAtIndex:indexPath.row] objectForKey:kQuestionImgStr];
    if (imgs && imgs.count > 0) {
        height += kCommunityImageWidth + 10;
    }
    
    return 2 + kMainSpace + kHeightOfCellHeaderImage + kMainSpace + height + 10 + 15 + 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int questionId = [[[self.questionsInfos objectAtIndex:indexPath.row] objectForKey:kQuestionId] intValue];
    [self pushQuestionDetailWithQuestionId:questionId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questionsInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"questionCell";
    CommunityTableViewCell *cell = (CommunityTableViewCell *)[UIUtility getCellWithCellName:cellName inTableView:tableView andCellClass:[CommunityTableViewCell class]];
    cell.isCalculatedDate = NO;
    cell.isShowFullContent = NO;
    
    NSArray *imgs = [[self.questionsInfos objectAtIndex:indexPath.row] objectForKey:kQuestionImgStr];
    if (imgs && imgs.count > 0) {
        cell.isQuestionDetail = YES;
    }
    
    [cell resetCellWithInfo:[self.questionsInfos objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)loadData {
    NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
    [tmpDic setObject:@"前段时间去拿了证，还是兑现了承诺，可惜帖子不能一一回复了。总之一句话，感谢考必备以及那么多工作人员做出这么好的软件方便造福广大人民群众。" forKey:kQuestionContent];
    [tmpDic setObject:@"2017/10/28 08:29" forKey:kQuestionTime];
    [tmpDic setObject:@(123) forKey:kQuestionId];
    [tmpDic setObject:@(12) forKey:kQuestionSeePeopleCount];
    [tmpDic setObject:@(23) forKey:kQuestionQuizzerId];
    [tmpDic setObject:@"刘语熙Frank" forKey:kQuestionQuizzerUserName];
    [tmpDic setObject:@"jh" forKey:kQuestionQuizzerHeaderImageUrl];
    [tmpDic setObject:@(3) forKey:kQuestionReplyCount];
    
    NSMutableDictionary *tmpDic1 = [[NSMutableDictionary alloc] init];
    [tmpDic1 setObject:@"有人了解初级么，难不难啊？都需要些什么？想做题请问那1500题库怎么做？" forKey:kQuestionContent];
    [tmpDic1 setObject:@"2017/10/28 08:29" forKey:kQuestionTime];
    [tmpDic1 setObject:@(123) forKey:kQuestionId];
    [tmpDic1 setObject:@(12) forKey:kQuestionSeePeopleCount];
    [tmpDic1 setObject:@(23) forKey:kQuestionQuizzerId];
    [tmpDic1 setObject:@"简单的快乐" forKey:kQuestionQuizzerUserName];
    [tmpDic1 setObject:@"jh" forKey:kQuestionQuizzerHeaderImageUrl];
    [tmpDic1 setObject:@(3) forKey:kQuestionReplyCount];
    [tmpDic1 setObject:@[@"http://pic33.nipic.com/20130906/12906030_152844052000_2.png", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494647348347&di=5b87aa438213b91a01eee74c191bacb6&imgtype=0&src=http%3A%2F%2Fww1.sinaimg.cn%2Flarge%2Fbca0b9cfjw1dzbw1juu4dj.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494647348347&di=02f5b2e3f8f09ee2d1fb527ce822d405&imgtype=0&src=http%3A%2F%2Fdown.laifudao.com%2Ftupian%2F2011101281241.jpg"] forKey:kQuestionImgStr];
    
    NSMutableDictionary *tmpDic2 = [[NSMutableDictionary alloc] init];
    [tmpDic2 setObject:@"前段时间去拿了证，还是兑现了承诺，可惜帖子不能一一回复了。总之一句话，感谢考必备以及那么多工作人员做出这么好的软件方便造福广大人民群众。" forKey:kQuestionContent];
    [tmpDic2 setObject:@"2017/10/28 08:29" forKey:kQuestionTime];
    [tmpDic2 setObject:@(123) forKey:kQuestionId];
    [tmpDic2 setObject:@(12) forKey:kQuestionSeePeopleCount];
    [tmpDic2 setObject:@(23) forKey:kQuestionQuizzerId];
    [tmpDic2 setObject:@"sanosidhf" forKey:kQuestionQuizzerUserName];
    [tmpDic2 setObject:@"jh" forKey:kQuestionQuizzerHeaderImageUrl];
    [tmpDic2 setObject:@(3) forKey:kQuestionReplyCount];
    [tmpDic2 setObject:@[@"http://pic33.nipic.com/20130906/12906030_152844052000_2.png", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494647348347&di=02f5b2e3f8f09ee2d1fb527ce822d405&imgtype=0&src=http%3A%2F%2Fdown.laifudao.com%2Ftupian%2F2011101281241.jpg"] forKey:kQuestionImgStr];
    
    NSMutableDictionary *tmpDic3 = [[NSMutableDictionary alloc] init];
    [tmpDic3 setObject:@"前段时间去拿了证，还是兑现了承诺，可惜帖子不能一一回复了。总之一句话，感谢考必备以及那么多工作人员做出这么好的软件方便造福广大人民群众。" forKey:kQuestionContent];
    [tmpDic3 setObject:@"2017/10/28 08:29" forKey:kQuestionTime];
    [tmpDic3 setObject:@(123) forKey:kQuestionId];
    [tmpDic3 setObject:@(12) forKey:kQuestionSeePeopleCount];
    [tmpDic3 setObject:@(23) forKey:kQuestionQuizzerId];
    [tmpDic3 setObject:@"刘语熙Frank" forKey:kQuestionQuizzerUserName];
    [tmpDic3 setObject:@"jh" forKey:kQuestionQuizzerHeaderImageUrl];
    [tmpDic3 setObject:@(3) forKey:kQuestionReplyCount];
    
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:tmpDic];
    [array addObject:tmpDic1];
    [array addObject:tmpDic2];
    [array addObject:tmpDic3];
    
    self.questionsInfos = [array copy];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
