//
//  SimulateResultViewController.m
//  Accountant
//
//  Created by aaa on 2017/4/5.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "SimulateResultViewController.h"
#import "UIMacro.h"
#import "CommonMacro.h"
#import "TestManager.h"
#import "SimulateResultCollectionViewCell.h"
#import "SimulateresultCollectionReusableView.h"
#import "SimulateresulrHeadCell.h"
#import "SimulateQuestionAnalysisViewController.h"

@interface SimulateResultViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSDictionary * dataDic;

@end

@implementation SimulateResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataDic = [NSDictionary dictionary];
    self.dataDic = [[TestManager sharedManager]getSimulateresult];
    [self navigationViewSetup];
    [self contentViewSetup];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"测试结果";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)contentViewSetup
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight ) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[SimulateResultCollectionViewCell class] forCellWithReuseIdentifier:@"simulaterestltcellid"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SimulateresulrHeadCell" bundle:nil] forCellWithReuseIdentifier:@"SimulateresulrHeadCellId"];
    [self.collectionView registerClass:[SimulateresultCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simulateresultReusableViewid"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    
    UIView * lookquestiondetailView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - kTabBarHeight - kNavigationBarHeight - kStatusBarHeight, kScreenWidth, kTabBarHeight)];
    lookquestiondetailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lookquestiondetailView];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, .8)];
    lineView.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [lookquestiondetailView addSubview:lineView];
    
    UIButton * lookAllQuestionBT = [UIButton buttonWithType:UIButtonTypeCustom];
    lookAllQuestionBT.frame = CGRectMake(25, (kTabBarHeight - 30) / 2, kScreenWidth / 2 - 50, 30);
    lookAllQuestionBT.backgroundColor = kCommonNavigationBarColor;
    lookAllQuestionBT.layer.cornerRadius = 15;
    lookAllQuestionBT.layer.masksToBounds = YES;
    lookAllQuestionBT.titleLabel.font = [UIFont systemFontOfSize:14];
    [lookAllQuestionBT setTitle:@"查看全部解析" forState:UIControlStateNormal];
    [lookAllQuestionBT addTarget:self action:@selector(lookAllquestion) forControlEvents:UIControlEventTouchUpInside];
    [lookquestiondetailView addSubview:lookAllQuestionBT];
    
    UIButton * lookWrongQuestionBT = [UIButton buttonWithType:UIButtonTypeCustom];
    lookWrongQuestionBT.frame = CGRectMake(25 + kScreenWidth / 2, (kTabBarHeight - 30) / 2, kScreenWidth / 2 - 50, 30);
    lookWrongQuestionBT.backgroundColor = kCommonNavigationBarColor;
    lookWrongQuestionBT.layer.cornerRadius = 15;
    lookWrongQuestionBT.layer.masksToBounds = YES;
    lookWrongQuestionBT.titleLabel.font = [UIFont systemFontOfSize:14];
    [lookWrongQuestionBT setTitle:@"查看错题解析" forState:UIControlStateNormal];
    [lookWrongQuestionBT addTarget:self action:@selector(lookWrongquestion) forControlEvents:UIControlEventTouchUpInside];
    [lookquestiondetailView addSubview:lookWrongQuestionBT];
    
}

- (void)lookAllquestion
{
    SimulateQuestionAnalysisViewController * simulateresultVC = [[SimulateQuestionAnalysisViewController alloc]init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:simulateresultVC animated:YES];
}

- (void)lookWrongquestion
{
    SimulateQuestionAnalysisViewController * simulateresultVC = [[SimulateQuestionAnalysisViewController alloc]init];
    simulateresultVC.wrongQuestion = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:simulateresultVC animated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        SimulateresulrHeadCell * cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"SimulateresulrHeadCellId" forIndexPath:indexPath];
        cell1.time = self.time.intValue;
        [cell1 resetWithInfo:self.dataDic];
        
        return cell1;
    }
    
    SimulateResultCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simulaterestltcellid" forIndexPath:indexPath];
    if (indexPath.section == 1) {
        if ([[self.dataDic objectForKey:kSinglequistionArr] count] > 0) {
            [cell resetCellWithinfo:[[self.dataDic objectForKey:kSinglequistionArr] objectAtIndex:indexPath.row]];
            cell.questionNumberLabel.text =
            [NSString stringWithFormat:@"%@", [[[self.dataDic objectForKey:kSinglequistionArr] objectAtIndex:indexPath.row] objectForKey:kTestQuestionNumber]];
        }else if([[self.dataDic objectForKey:kMultiplequistionArr] count] > 0)
        {
            [cell resetCellWithinfo:[[self.dataDic objectForKey:kMultiplequistionArr] objectAtIndex:indexPath.row]];
            cell.questionNumberLabel.text = [NSString stringWithFormat:@"%@", [[[self.dataDic objectForKey:kMultiplequistionArr] objectAtIndex:indexPath.row] objectForKey:kTestQuestionNumber]];
        }else if([[self.dataDic objectForKey:kJudgequistionArr] count] > 0)
        {
            [cell resetCellWithinfo:[[self.dataDic objectForKey:kJudgequistionArr] objectAtIndex:indexPath.row]];
            cell.questionNumberLabel.text = [NSString stringWithFormat:@"%@", [[[self.dataDic objectForKey:kJudgequistionArr] objectAtIndex:indexPath.row] objectForKey:kTestQuestionNumber]];
        }
    }else if (indexPath.section == 2)
    {
        if([[self.dataDic objectForKey:kSinglequistionArr] count] > 0 && [[self.dataDic objectForKey:kMultiplequistionArr] count] > 0)
        {
            [cell resetCellWithinfo:[[self.dataDic objectForKey:kMultiplequistionArr] objectAtIndex:indexPath.row]];
            
            cell.questionNumberLabel.text = [NSString stringWithFormat:@"%@", [[[self.dataDic objectForKey:kMultiplequistionArr] objectAtIndex:indexPath.row] objectForKey:kTestQuestionNumber]];
        }else if([[self.dataDic objectForKey:kJudgequistionArr] count] > 0)
        {
           [cell resetCellWithinfo:[[self.dataDic objectForKey:kJudgequistionArr] objectAtIndex:indexPath.row]];
            cell.questionNumberLabel.text = [[[self.dataDic objectForKey:kJudgequistionArr] objectAtIndex:indexPath.row] objectForKey:kTestQuestionNumber];
        }
    }else if (indexPath.section == 3)
    {
        [cell resetCellWithinfo:[[self.dataDic objectForKey:kJudgequistionArr] objectAtIndex:indexPath.row]];
        cell.questionNumberLabel.text = [NSString stringWithFormat:@"%@", [[[self.dataDic objectForKey:kJudgequistionArr] objectAtIndex:indexPath.row] objectForKey:kTestQuestionNumber]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    SimulateResultCollectionViewCell * cell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section]];
    SimulateQuestionAnalysisViewController * simulateresultVC = [[SimulateQuestionAnalysisViewController alloc]init];
    simulateresultVC.currentQuestionIndex = cell.questionNumberLabel.text.intValue - 1;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:simulateresultVC animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 0) {
            SimulateresultCollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simulateresultReusableViewid" forIndexPath:indexPath];
            reusableview = headview;
        }else if (indexPath.section == 1) {
            if ([[self.dataDic objectForKey:kSinglequistionArr] count] > 0) {
                SimulateresultCollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simulateresultReusableViewid" forIndexPath:indexPath];
                [headview resetWithTitle:@"单选"];
                reusableview = headview;
            }else if([[self.dataDic objectForKey:kMultiplequistionArr] count] > 0)
            {
                SimulateresultCollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simulateresultReusableViewid" forIndexPath:indexPath];
                [headview resetWithTitle:@"多选"];
                reusableview = headview;
            }else if([[self.dataDic objectForKey:kJudgequistionArr] count] > 0)
            {
                SimulateresultCollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simulateresultReusableViewid" forIndexPath:indexPath];
                [headview resetWithTitle:@"判断"];
                reusableview = headview;
            }
        }else if (indexPath.section == 2)
        {
            if([[self.dataDic objectForKey:kMultiplequistionArr] count] > 0)
            {
                SimulateresultCollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simulateresultReusableViewid" forIndexPath:indexPath];
                [headview resetWithTitle:@"多选"];
                reusableview = headview;
            }else if([[self.dataDic objectForKey:kJudgequistionArr] count] > 0)
            {
                SimulateresultCollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simulateresultReusableViewid" forIndexPath:indexPath];
                [headview resetWithTitle:@"判断"];
                reusableview = headview;
            }
        }else if (indexPath.section == 3)
        {
            SimulateresultCollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simulateresultReusableViewid" forIndexPath:indexPath];
            [headview resetWithTitle:@"判断"];
            reusableview = headview;
        }
    }
    return reusableview;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 1) {
        if ([[self.dataDic objectForKey:kSinglequistionArr] count] > 0) {
            return [[self.dataDic objectForKey:kSinglequistionArr] count];
        }else if([[self.dataDic objectForKey:kMultiplequistionArr] count] > 0)
        {
            return [[self.dataDic objectForKey:kMultiplequistionArr] count];
        }else if([[self.dataDic objectForKey:kJudgequistionArr] count] > 0)
        {
            return [[self.dataDic objectForKey:kJudgequistionArr] count];
        }else
        {
            return 0;
        }
    }else if (section == 2)
    {
        if([[self.dataDic objectForKey:kMultiplequistionArr] count] > 0)
        {
            return [[self.dataDic objectForKey:kMultiplequistionArr] count];
        }else if([[self.dataDic objectForKey:kJudgequistionArr] count] > 0)
        {
            return [[self.dataDic objectForKey:kJudgequistionArr] count];
        }else
        {
            return 0;
        }
    }else if (section == 3)
    {
        return [[self.dataDic objectForKey:kJudgequistionArr] count];
    }else
    {
        return 1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 132);
    }else
    {
        return CGSizeMake((int)(self.view.frame.size.width / 6), self.view.frame.size.width / 6);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(0, 0);
    }else
    {
        return CGSizeMake(kScreenWidth, 44);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    int number = 0;
    if ([[self.dataDic objectForKey:kSinglequistionArr] count] > 0) {
        number++;
    }
    if([[self.dataDic objectForKey:kMultiplequistionArr] count] > 0)
    {
        number++;
    }
    if([[self.dataDic objectForKey:kJudgequistionArr] count] > 0)
    {
        number++;
    }
    return number + 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
