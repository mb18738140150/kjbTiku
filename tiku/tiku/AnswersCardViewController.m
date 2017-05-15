//
//  AnswersCardViewController.m
//  Accountant
//
//  Created by aaa on 2017/3/30.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "AnswersCardViewController.h"
#import "UIMacro.h"
#import "CommonMacro.h"
#import "NotificaitonMacro.h"
#import "AnswerCardAnswerCollectionViewCell.h"
#import "AnswerCardHeaderCollectionViewCell.h"
#import "AnswerCardFooterCollectionViewCell.h"
#import "TestManager.h"
#import "SVProgressHUD.h"
#import "SimulateResultViewController.h"

@interface AnswersCardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIAlertViewDelegate>

@property (nonatomic,strong) UICollectionView                   *collectView;
@property (nonatomic,strong) UICollectionViewFlowLayout         *flowLayout;

@property (nonatomic,strong) NSArray                            *answers;

@property (nonatomic, copy)SubmitBlock myBlock;

@property (nonatomic,strong)UIButton * bottomMenuView;

@end

@implementation AnswersCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationViewSetup];
    [self contentViewSetup];
    
    self.answers = [[TestManager sharedManager] getSimulateMyAnswersInfo];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(submitResult:) name:kNotificationOfsubmitSimulateResult object:nil];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
//    self.navigationItem.rightBarButtonItem = item;
}

- (void)submitResult:(NSNotification *)notification
{
    [SVProgressHUD dismiss];
    NSNumber *time = [notification.userInfo objectForKey:@"time"];
    SimulateResultViewController * simulateresultVC = [[SimulateResultViewController alloc]init];
    simulateresultVC.time = time;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:simulateresultVC animated:YES];
}

- (void)submiteBlock:(SubmitBlock)block
{
    self.myBlock = [block copy];
}

#pragma mark 
- (void)submit
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定提交试卷？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    alert.tag = 1000;
    
}

- (void)showResult
{
    [SVProgressHUD dismiss];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {
            [self performSelector:@selector(showResult) withObject:nil afterDelay:1];
            if (self.myBlock) {
                self.myBlock();
            }
        }
    }
}

#pragma mark - collect view delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.answers.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerCardAnswerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"answerCardAnswerCell" forIndexPath:indexPath];
    [cell resetCellWithInfo:[self.answers objectAtIndex:indexPath.row]];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = kScreenWidth/6-1;
    return CGSizeMake(width, width);
}

- (void)dissmiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)contentViewSetup
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing= 0;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight -kTabBarHeight) collectionViewLayout:self.flowLayout];
    [self.collectView registerClass:[AnswerCardAnswerCollectionViewCell class] forCellWithReuseIdentifier:@"answerCardAnswerCell"];
    [self.collectView registerClass:[AnswerCardFooterCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"answerCardFooterCell"];
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectView];
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    
    self.bottomMenuView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomMenuView.frame = CGRectMake(0, kScreenHeight-kStatusBarHeight - kNavigationBarHeight - kTabBarHeight, kScreenWidth, kTabBarHeight);
    self.bottomMenuView.backgroundColor = kCommonNavigationBarColor;
    [self.bottomMenuView setTitle:@"提交" forState:UIControlStateNormal];
    [self.bottomMenuView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomMenuView addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomMenuView];
    
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"答题卡";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
}

- (void)dealloc
{
}

@end
