//
//  TestSimulateQuestionViewController.m
//  Accountant
//
//  Created by aaa on 2017/3/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestSimulateQuestionViewController.h"
#import "UIMacro.h"
#import "CommonMacro.h"
#import "TestManager.h"
#import "TestQuestionHeaderTableViewCell.h"
#import "TestQuestionContentTableViewCell.h"
#import "TestQuestionAnswerTableViewCell.h"
#import "TestQuestionResultTableViewCell.h"
#import "TestQuestionComplainTableViewCell.h"
#import "UIUtility.h"
#import "AnswersCardViewController.h"
#import "TestMacro.h"
#import "NotificaitonMacro.h"
#import "TestQuestioncollectView.h"
#import "SVProgressHUD.h"
#import "DelayButton+helper.h"
#import "SlideBlockView.h"
#import "UIView+HDExtension.h"

#define bottomButtonwidht (kScreenWidth-3) / 3
#define bottomButtonHeight kTabBarHeight - 1

@interface TestSimulateQuestionViewController ()<UITableViewDelegate,UITableViewDataSource,TestModule_SimulateScoreProtocol,UIGestureRecognizerDelegate, TestModule_CollectQuestionProtocol, TestModuleQuestionCollection, TestModule_UncollectQuestionProtocol, UITextViewDelegate>

@property (nonatomic,strong) UITableView            *contentTableView;

@property (nonatomic,strong) NSDictionary           *questionInfoDic;

@property (nonatomic,strong) UITableView            *nextOrPreviousTableView;

@property (nonatomic,assign) BOOL                    isShowAnswer;

@property (nonatomic,strong) NSMutableArray         *selectedArray;

@property (nonatomic,assign) int                     currentQuestionIndex;
@property (nonatomic,assign) int                     totalCount;

@property (nonatomic,strong) DelayButton               *nextQuestionButton;
@property (nonatomic,strong) DelayButton               *previousQuestionButton;
@property (nonatomic,strong) UIButton               *submitButton;

@property (nonatomic,strong) UIButton               *collecButton;

@property (nonatomic,strong) UIView                 *bottomMenuView;

//单选判断  点击选项就显示答案
@property (nonatomic,assign) BOOL                    isClickShowAnswer;

@property (nonatomic, strong) NSTimer               *timer;
@property (nonatomic, assign) int                    count;
@property (nonatomic, strong) UILabel               *timeLabel;
@property (nonatomic, strong)TestQuestioncollectView * collectView;

@property (nonatomic,strong) UISwipeGestureRecognizer *leftGesture;
@property (nonatomic,strong) UISwipeGestureRecognizer *rightGesture;

@property (nonatomic, strong)SlideBlockView * slideBlockView;
@property (nonatomic, assign)CGFloat tableviewHeight;
@property (nonatomic, strong)UITextView * cailiaoDetailLabel;

@end

@implementation TestSimulateQuestionViewController
- (void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundGrayColor;
    [[TestManager sharedManager] resetCurrentQuestionInfos];
    self.totalCount = [[TestManager sharedManager] getTestSimulateTotalCount];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.tableviewHeight = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight;
    [self navigationViewSetup];
    [self slideViewSetup];
    [self tableViewSetup];
    [self reloadQuestionInfo];
    [self addGesture];
    [self setrightNavigationItem:self.questionInfoDic];
    [self reloadCurrentTableView];
    self.count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatShowTime:) userInfo:@"admin" repeats:YES];
    
}
- (void)addGesture
{
    _leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextQuestion)];
    _leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.contentTableView addGestureRecognizer:_leftGesture];
    _rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousQuestion)];
    _rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.contentTableView addGestureRecognizer:_rightGesture];
}

static bool isCailiao;
static bool isFirstCailiaoQuestion;

- (void)reloadQuestionInfo
{
    self.questionInfoDic = [[TestManager sharedManager] getCurrentSimulateQuestionInfo];
    self.currentQuestionIndex = [[TestManager sharedManager] getCurrentQuestionIndex];
    
    NSString *type = [self.questionInfoDic objectForKey:kTestQuestionType];
    if ([type isEqualToString:@"单选"] || [type isEqualToString:@"判断"]) {
        self.isClickShowAnswer = YES;
    }else{
        self.isClickShowAnswer = NO;
    }
    
    NSLog(@"%@", [self.questionInfoDic description]);
    
    if (![[self.questionInfoDic objectForKey:kQuestionCaseInfo] isEqualToString:@""]) {
        self.slideBlockView.hidden = NO;
        isCailiao = true;
        if (![self.cailiaoDetailLabel.text isEqualToString:@""]) {
            
            NSLog(@"self.cailiaoDetailLabel.text = %@", self.cailiaoDetailLabel.text);
            NSLog(@"[self.questionInfoDic objectForKey:kQuestionCaseInfo] = %@", [self.questionInfoDic objectForKey:kQuestionCaseInfo]);
            if (![self.cailiaoDetailLabel.text isEqualToString:[self.questionInfoDic objectForKey:kQuestionCaseInfo]]) {
                self.cailiaoDetailLabel.attributedText = [UIUtility getSpaceLabelStr:[self.questionInfoDic objectForKey:kQuestionCaseInfo] withFont:kMainFont color:kMainTextColor_100];
            }
            isFirstCailiaoQuestion = false;
        }else
        {
            isFirstCailiaoQuestion = true;
            self.cailiaoDetailLabel.attributedText = [UIUtility getSpaceLabelStr:[self.questionInfoDic objectForKey:kQuestionCaseInfo] withFont:kMainFont color:kMainTextColor_100];
            [self changetableview];
        }
    }else
    {
        self.slideBlockView.hidden = YES;
        self.cailiaoDetailLabel.text = @"";
        isCailiao = false;
    }
    
    self.isShowAnswer = [[self.questionInfoDic objectForKey:kTestQuestionIsAnswered] boolValue];
    if (self.isShowAnswer) {
        self.selectedArray = [[self.questionInfoDic objectForKey:kTestQuestionSelectedAnswers] mutableCopy];
    }else
    {
        self.selectedArray = [[NSMutableArray alloc] init];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.currentQuestionIndex > 0) {
        [[TestManager sharedManager] resetCurrentQuestionInfoswith:self.currentQuestionIndex];
    }
}

- (void)submitQuestion
{
    if (self.selectedArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先选择答案" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self.selectedArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *num1 = obj1;
        NSNumber *num2 = obj2;
        NSComparisonResult result = [num1 compare:num2];
        return result == NSOrderedDescending;
    }];
    [[TestManager sharedManager] submitSimulateAnswers:self.selectedArray andQuestionIndex:self.currentQuestionIndex];
    
    [self addQuestionDetailHistory];
    
    if (self.currentQuestionIndex < self.totalCount-1){
        [self nextQuestion];
    }else{
        [self didShowAnsersCard];
    }
    
}

- (void)changetableview
{
    CGFloat point_y = 0.0;
    CGFloat height = 0.0;
    
    if (isCailiao) {
        if (isFirstCailiaoQuestion) {
            point_y = 60 + 30;
            height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - 60 - 30;
            self.tableviewHeight = height;
            self.slideBlockView.hd_y = 60;
            self.slideBlockView.alpha = 0;
        }else
        {
            point_y = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - self.tableviewHeight;
            height = self.tableviewHeight;
        }
    }else
    {
        point_y = 0;
        height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight;
        self.tableviewHeight = height;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.slideBlockView.alpha = 1;
        self.nextOrPreviousTableView.frame = CGRectMake(0, point_y, kScreenWidth, self.tableviewHeight);
        self.contentTableView.frame = CGRectMake(0, point_y, kScreenWidth, self.tableviewHeight);
    }];
    
}

- (void)nextQuestion
{
    if (self.currentQuestionIndex < self.totalCount-1) {
        [[TestManager sharedManager] nextQuestion];
        [self reloadQuestionInfo];
        [self reloadNextOrPreviousTableView];
        
        
        CGFloat point_y = 0.0;
        CGFloat height = 0.0;
        
        if (isCailiao) {
            if (isFirstCailiaoQuestion) {
                point_y = 60 + 30;
                height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - 60 - 30;
                self.tableviewHeight = height;
                self.slideBlockView.hd_y = 60;
                self.slideBlockView.alpha = 0;
            }else
            {
                point_y = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - self.tableviewHeight;
                height = self.tableviewHeight;
            }
        }else
        {
            point_y = 0;
            height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight;
            self.tableviewHeight = height;
        }
        
        self.nextOrPreviousTableView.frame = CGRectMake(kScreenWidth, point_y, kScreenWidth, self.tableviewHeight);
        
        [UIView animateWithDuration:0.5 animations:^{
            self.nextOrPreviousTableView.frame = CGRectMake(0, point_y, kScreenWidth, self.tableviewHeight);
            self.contentTableView.frame = CGRectMake(-kScreenWidth, point_y, kScreenWidth, self.tableviewHeight);
            self.slideBlockView.alpha = 1;
        } completion:^(BOOL finished) {
            self.contentTableView.frame = CGRectMake(0, point_y, kScreenWidth, self.tableviewHeight);
            [self reloadCurrentTableView];
            [self setrightNavigationItem:self.questionInfoDic];
        }];
    }
}

- (void)previousQuestion
{
    if (self.currentQuestionIndex != 0) {
        [[TestManager sharedManager] previousQuestion];
        [self reloadQuestionInfo];
        [self reloadNextOrPreviousTableView];
        
        
        CGFloat point_y = 0.0;
        CGFloat height = 0.0;
        
        if (isCailiao) {
            if (isFirstCailiaoQuestion) {
                point_y = 60 + 30;
                height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - 60 - 30;
                self.tableviewHeight = height;
                self.slideBlockView.hd_y = 60;
                self.slideBlockView.alpha = 0;
            }else
            {
                point_y = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - self.tableviewHeight;
                height = self.tableviewHeight;
            }
        }else
        {
            point_y = 0;
            height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight;
            self.tableviewHeight = height;
        }
        
        self.nextOrPreviousTableView.frame = CGRectMake(-kScreenWidth, point_y, kScreenWidth, self.tableviewHeight);
        
        [UIView animateWithDuration:0.5 animations:^{
            self.nextOrPreviousTableView.frame = CGRectMake(0, point_y, kScreenWidth, self.tableviewHeight);
            self.contentTableView.frame = CGRectMake(kScreenWidth, point_y, kScreenWidth, self.tableviewHeight);
            self.slideBlockView.alpha = 1;
        } completion:^(BOOL finished) {
            self.contentTableView.frame = CGRectMake(0, point_y, kScreenWidth, self.tableviewHeight);
            [self reloadCurrentTableView];
        }];
    }
}

/*- (void)finishTest
{
    if (self.selectedArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先选择答案" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self.selectedArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *num1 = obj1;
        NSNumber *num2 = obj2;
        NSComparisonResult result = [num1 compare:num2];
        return result == NSOrderedDescending;
    }];
    [[TestManager sharedManager] submitSimulateAnswers:self.selectedArray andQuestionIndex:self.currentQuestionIndex];
    [self.contentTableView reloadData];
    
    NSArray *array = [[TestManager sharedManager] getSimulateMyAnswersInfo];
    NSLog(@"%@",array);
    [[TestManager sharedManager] didRequestTestSimulateScoreWithInfo:array andNotifiedObject:self];
}*/

- (void)reloadCurrentTableView
{
    [self.contentTableView reloadData];
}

- (void)reloadNextOrPreviousTableView
{
    [self.nextOrPreviousTableView reloadData];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

- (void)didShowAnsersCard
{
    AnswersCardViewController *vc = [[AnswersCardViewController alloc] init];
    __weak TestSimulateQuestionViewController * weakSelf = self;
    [vc submiteBlock:^{
        [weakSelf.timer invalidate];
        weakSelf.timer = nil;
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationOfsubmitSimulateResult object:nil userInfo:@{@"time":@(weakSelf.count)}];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:vc animated:YES];
/*    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];*/
}

- (void)repeatShowTime:(NSTimer *)tempTimer {
    self.count++;
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",self.count/60,self.count%60];
}

- (void)addQuestionDetailHistory
{
    BOOL isCorrect;
    if ([[self.questionInfoDic objectForKey:kTestQuestionCorrectAnswersId] isEqualToString:[self getSelectedAnswersIdString]]) {
        isCorrect = YES;
    }else{
        isCorrect = NO;
    }
    NSDictionary *dic = @{kTestAddDetailHistoryLogId:@([[TestManager sharedManager] getLogId]),
                          kTestQuestionId:[self.questionInfoDic objectForKey:kTestQuestionId],
                          kTestAnserId:[self getSelectedAnswersIdString],
                          kTestQuestionResult:@(isCorrect)};
    [[TestManager sharedManager] didRequestAddTestHistoryDetailWithInfo:dic];
}

- (NSString *)getSelectedAnswersIdString
{
    NSMutableString *myStr = [[NSMutableString alloc] init];
    for (NSNumber *number in self.selectedArray) {
        [myStr appendString:[NSString stringWithFormat:@"%@",number]];
    }
    return myStr;
}

#pragma mark - delegate
- (void)didRequestSimulateScoreSuccess
{
}

- (void)didRequestSimulateScoreFailed:(NSString *)failedInfo
{
    
}

#pragma mark - collectdelegate
- (void)didQuestionCollect
{
    [SVProgressHUD show];
    [[TestManager sharedManager] didRequestTestCollectQuestionWithQuestionId:[[self.questionInfoDic objectForKey:kTestQuestionId] intValue] andNotifiedObject:self];
}

- (void)didQustionUncollect
{
    [SVProgressHUD show];
    [[TestManager sharedManager] didRequestTestUncollectQuestionWithQuestionId:[[self.questionInfoDic objectForKey:kTestQuestionId] intValue] andNotifiedObject:self];
}

- (void)didRequestCollectQuestionSuccess
{
    [SVProgressHUD dismiss];
    
    [TestManager sharedManager].colectType = CollectTypeSimulate;
    [[TestManager sharedManager] collectCurrentQuestion];
    [self reloadQuestionInfo];
    [self reloadCurrentTableView];
    [self setrightNavigationItem:self.questionInfoDic];
}

- (void)didRequestCollectQuestionFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestUncollectQuestionSuccess
{
    [SVProgressHUD dismiss];
   
    [TestManager sharedManager].colectType = CollectTypeSimulate;
    
    [[TestManager sharedManager] uncollectCurrentQuestion];
    [self reloadQuestionInfo];
    [self reloadCurrentTableView];
    [self setrightNavigationItem:self.questionInfoDic];
}

- (void)didRequestUncollectQuestionFailed:(NSString *)failedInfo
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
    self.navigationItem.title = @"模拟";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//    self.collectView = [[TestQuestioncollectView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
//    self.collectView.delegate = self;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_collectView];
}
- (void)setrightNavigationItem:(NSDictionary *)dic
{
    [self.collectView resetWithInfo:dic andIsShowCollect:YES];
}

- (void)slideViewSetup
{
    self.slideBlockView = [[SlideBlockView alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 24, 60, 48, 30)];
    __weak typeof(self)weakSelf = self;
    [self.slideBlockView moveSlideBlock:^(CGPoint point) {
        
        weakSelf.cailiaoDetailLabel.hd_height = CGRectGetMaxY(weakSelf.slideBlockView.frame);
        weakSelf.contentTableView.hd_y = CGRectGetMaxY(weakSelf.slideBlockView.frame);
        
        weakSelf.contentTableView.hd_height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - CGRectGetMaxY(weakSelf.slideBlockView.frame);
        
        weakSelf.nextOrPreviousTableView.hd_y = CGRectGetMaxY(weakSelf.slideBlockView.frame);
        weakSelf.nextOrPreviousTableView.hd_height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - CGRectGetMaxY(weakSelf.slideBlockView.frame);
        
        weakSelf.tableviewHeight = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - CGRectGetMaxY(weakSelf.slideBlockView.frame);
    }];
    [self.view addSubview:self.slideBlockView];
}

- (void)tableViewSetup
{
    self.view.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:kCommonNavigationBarColor forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(submitQuestion) forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.frame = CGRectMake(kScreenWidth / 2 - 50, 10, 100, 40);
    self.submitButton.layer.cornerRadius = 3;
    self.submitButton.layer.masksToBounds = YES;
    self.submitButton.layer.borderColor = kTableViewCellSeparatorColor.CGColor;
    self.submitButton.layer.borderWidth = 1;
    
    self.nextOrPreviousTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight) style:UITableViewStylePlain];
    self.nextOrPreviousTableView.delegate = self;
    self.nextOrPreviousTableView.dataSource = self;
    self.nextOrPreviousTableView.bounces = NO;
    self.nextOrPreviousTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.nextOrPreviousTableView];
    
    self.contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight) style:UITableViewStylePlain];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.bounces = NO;
//    self.contentTableView.backgroundColor = [UIColor grayColor];
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.contentTableView];
    
    
    self.bottomMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kStatusBarHeight - kNavigationBarHeight - kTabBarHeight, kScreenWidth, kTabBarHeight)];
    self.bottomMenuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomMenuView];
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    topLineView.backgroundColor = kTableViewCellSeparatorColor;
    [self.bottomMenuView addSubview:topLineView];
    
    self.previousQuestionButton = [DelayButton buttonWithType:UIButtonTypeCustom];
    self.previousQuestionButton.frame = CGRectMake(0, 0, bottomButtonwidht, bottomButtonHeight);
    [self.previousQuestionButton setImage:[UIImage imageNamed:@"bluetitle"] forState:UIControlStateNormal];
    [self.previousQuestionButton addTarget:self action:@selector(previousQuestion) forControlEvents:UIControlEventTouchUpInside];
//    [self.bottomMenuView addSubview:self.previousQuestionButton];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.previousQuestionButton.frame), 10, 1, kTabBarHeight - 20)];
    lineView1.backgroundColor = kTableViewCellSeparatorColor;
//    [self.bottomMenuView addSubview:lineView1];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, bottomButtonwidht, bottomButtonHeight);
    [btn1 setTitle:@"答题卡" forState:UIControlStateNormal];
    btn1.titleLabel.font = kMainFont;
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(didShowAnsersCard) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomMenuView addSubview:btn1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame), 10, 1, kTabBarHeight - 20)];
    lineView2.backgroundColor = kTableViewCellSeparatorColor;
    [self.bottomMenuView addSubview:lineView2];
    
    self.collectView = [[TestQuestioncollectView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView2.frame), 0, bottomButtonwidht, bottomButtonHeight)];
    self.collectView.delegate = self;
    [self.bottomMenuView addSubview:self.collectView];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.collectView.frame), 10, 1, kTabBarHeight - 20)];
    lineView3.backgroundColor = kTableViewCellSeparatorColor;
    [self.bottomMenuView addSubview:lineView3];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView3.frame), 0, bottomButtonwidht, bottomButtonHeight)];
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.text = @"00:00";
    self.timeLabel.font = kMainFont;
    [self.bottomMenuView addSubview:self.timeLabel];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLabel.frame), 10, 1, kTabBarHeight - 20)];
    lineView4.backgroundColor = kTableViewCellSeparatorColor;
//    [self.bottomMenuView addSubview:lineView4];
    
    self.nextQuestionButton = [DelayButton buttonWithType:UIButtonTypeCustom];
    self.nextQuestionButton.frame = CGRectMake(CGRectGetMaxX(lineView4.frame), 0, bottomButtonwidht, bottomButtonHeight);
    [self.nextQuestionButton setImage:[UIImage imageNamed:@"bluetitle"] forState:UIControlStateNormal];
    [self.nextQuestionButton addTarget:self action:@selector(nextQuestion) forControlEvents:UIControlEventTouchUpInside];
//    [self.bottomMenuView addSubview:self.nextQuestionButton];
    
    self.cailiaoDetailLabel = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    self.cailiaoDetailLabel.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    self.cailiaoDetailLabel.textColor = kCommonNavigationBarColor;
    self.cailiaoDetailLabel.delegate = self;
    self.cailiaoDetailLabel.editable = YES;
    [self.view addSubview:self.cailiaoDetailLabel];
    
    [self.view insertSubview:self.cailiaoDetailLabel belowSubview:self.nextOrPreviousTableView];
    [self.view bringSubviewToFront:self.slideBlockView];
    
}

#pragma mark - table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        NSArray *array = [self.questionInfoDic objectForKey:kTestQuestionAnswers];
        NSDictionary *infoDic = [array objectAtIndex:indexPath.row];
        NSString *answerId = [infoDic objectForKey:kTestAnserId];
        if (self.isClickShowAnswer){
            [self.selectedArray removeAllObjects];
            [self.selectedArray addObject:answerId];
        }else{
            if ([self.selectedArray containsObject:answerId]) {
                [self.selectedArray removeObject:answerId];
            }else{
                [self.selectedArray addObject:answerId];
            }
        }
        [tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TestQuestionHeaderTableViewCell *cell = (TestQuestionHeaderTableViewCell *)[UIUtility getCellWithCellName:@"testQuestionHeaderCell" inTableView:tableView andCellClass:[TestQuestionHeaderTableViewCell class]];
        [cell resetWithInfo:self.questionInfoDic andIsShowCollect:NO];
        return cell;
    }
    if (indexPath.section == 1) {
        TestQuestionContentTableViewCell *cell = (TestQuestionContentTableViewCell *)[UIUtility getCellWithCellName:@"testContentCell" inTableView:tableView andCellClass:[TestQuestionContentTableViewCell class]];
        cell.questionCurrentIndex = self.currentQuestionIndex;
        cell.questionTotalCount = self.totalCount;
        [cell resetWithInfo:self.questionInfoDic];
        return cell;
    }
    if (indexPath.section == 2) {
        TestQuestionAnswerTableViewCell *cell = (TestQuestionAnswerTableViewCell *)[UIUtility getCellWithCellName:@"testAnswerCell" inTableView:tableView andCellClass:[TestQuestionAnswerTableViewCell class]];
        NSArray *array = [self.questionInfoDic objectForKey:kTestQuestionAnswers];
        NSDictionary *infoDic = [array objectAtIndex:indexPath.row];
        BOOL isSelect = NO;
        NSString *answerId = [infoDic objectForKey:kTestAnserId];
        if ([self.selectedArray containsObject:answerId]) {
            isSelect = YES;
        }
        [cell resetWithInfo:infoDic andIsSelect:isSelect];
        return cell;
    }
    if (indexPath.section == 3) {
        UITableViewCell *cell = [UIUtility getCellWithCellName:@"testCertainCell" inTableView:tableView andCellClass:[UITableViewCell class]];
        [self.submitButton removeFromSuperview];
        
        [cell addSubview:_submitButton];
        NSLog(@"******");
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 10;
    }
    if (indexPath.section == 1) {
        CGFloat height = [UIUtility getSpaceLabelHeght:[self.questionInfoDic objectForKey:kTestQuestionContent] font:kMainFont width:(kScreenWidth - 40)];
        return height + 30 + 10;
    }
    if (indexPath.section == 2) {
        
        NSArray *array = [self.questionInfoDic objectForKey:kTestQuestionAnswers];
        NSDictionary *infoDic = [array objectAtIndex:indexPath.row];
        CGFloat minHeight = kHeightOfTestQuestionAnswer;
        
        CGFloat height = [UIUtility getHeightWithText:[infoDic objectForKey:kTestAnswerContent] font:kMainFont width:kScreenWidth - 80];
        if (height < minHeight) {
            height = minHeight;
        }
        return height + 10;
    }
    if (indexPath.section == 3) {
        return 50;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        NSArray *answers = [self.questionInfoDic objectForKey:kTestQuestionAnswers];
        return answers.count;
    }
    if (section == 3) {
        return 1;
    }
    NSLog(@"dshbj");
    return 0;
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
@end
