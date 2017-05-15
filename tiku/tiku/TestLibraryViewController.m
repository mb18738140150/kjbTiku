//
//  TestLibraryViewController.m
//  Accountant
//
//  Created by aaa on 2017/3/16.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TestLibraryViewController.h"
#import "UIMacro.h"
#import "CommonMacro.h"
#import "TestListViewController.h"
#import "TestSimulateViewController.h"
#import "SubCategoryCollectionViewCell.h"
#import "SimpleHeaderCollectionViewCell.h"
#import "TestQuestionTypeViewController.h"

@interface TestLibraryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSArray            *categoryArray;
@property (nonatomic,strong) NSArray            *subcategoryArray1;
@property (nonatomic,strong) NSArray            *subcategoryArray2;
@property (nonatomic,strong) NSArray            *subcategoryArray3;

@property (nonatomic,strong) UIView             *section1View;
@property (nonatomic,strong) UIView             *section2View;
@property (nonatomic,strong) UIView             *section3View;

@property (nonatomic,strong) NSString           *clickCateName;
@property (nonatomic,assign) int                 clickCateId;

@property (nonatomic,strong) UICollectionView   *collectView;
@property (nonatomic,strong) UICollectionViewFlowLayout         *flowLayout;

@end

@implementation TestLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.categoryArray = @[@"会计从业资格",@"初级会计职称",@"中级会计职称"];
    self.subcategoryArray1 = @[@{kTestCategoryName:@"会计基础",
                                 kTestCategoryImageName:@"classImg-1-2.png",
                                 kTestCategoryId:@(7)},
                               @{kTestCategoryName:@"财经法规",
                                 kTestCategoryImageName:@"classImg-1-3.png",
                                 kTestCategoryId:@(8)},
                               @{kTestCategoryName:@"会计电算化",
                                 kTestCategoryImageName:@"classImg-1-4.png",
                                 kTestCategoryId:@(9)}];
    self.subcategoryArray2 = @[@{kTestCategoryName:@"经济法基础",
                                 kTestCategoryImageName:@"classImg-2-2.png",
                                 kTestCategoryId:@(6)},
                               @{kTestCategoryName:@"初级会计实务",
                                 kTestCategoryImageName:@"classImg-2-3.png",
                                 kTestCategoryId:@(5)}];
    self.subcategoryArray3 = @[@{kTestCategoryName:@"中级会计实务",
                                 kTestCategoryImageName:@"classImg-3-2.png",
                                 kTestCategoryId:@(10)},
                               @{kTestCategoryName:@"中级经济法",
                                 kTestCategoryImageName:@"classImg-3-3.png",
                                 kTestCategoryId:@(11)},
                               @{kTestCategoryName:@"中级财务管理",
                                 kTestCategoryImageName:@"classImg-3-4.png",
                                 kTestCategoryId:@(12)}];
    
    [self navigationViewSetup];
    [self contentViewSetup];
    
}

- (void)pushTestListWithInfo:(NSDictionary *)info
{
//    TestListViewController *vc = [[TestListViewController alloc] init];
//    TestSimulateViewController *vc = [[TestSimulateViewController alloc] init];
    TestQuestionTypeViewController *vc = [[TestQuestionTypeViewController alloc] init];
    vc.cateName = [info objectForKey:kTestCategoryName];
    vc.cateId = [[info objectForKey:kTestCategoryId] intValue];
    vc.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - response func
- (void)click
{
    TestListViewController *vc = [[TestListViewController alloc] init];
    vc.cateName = self.clickCateName;
    vc.cateId = self.clickCateId;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ui

- (void)navigationViewSetup
{
    self.navigationItem.title = @"题  库";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"tm"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tm"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
}

- (void)contentViewSetup
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight) collectionViewLayout:self.flowLayout];
    [self.collectView registerClass:[SubCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"testSubCategoryCell"];
    [self.collectView registerClass:[SimpleHeaderCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"testCategoryHeader"];
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectView];
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
}

#pragma mark - collect view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self pushTestListWithInfo:[self.subcategoryArray1 objectAtIndex:indexPath.row]];
    }
    if (indexPath.section == 1) {
        [self pushTestListWithInfo:[self.subcategoryArray2 objectAtIndex:indexPath.row]];
    }
    if (indexPath.section == 2) {
        [self pushTestListWithInfo:[self.subcategoryArray3 objectAtIndex:indexPath.row]];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.subcategoryArray1.count;
    }
    if (section == 1) {
        return self.subcategoryArray2.count;
    }
    if (section == 2) {
        return self.subcategoryArray3.count;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"testSubCategoryCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell resetViewWithDic:[self.subcategoryArray1 objectAtIndex:indexPath.row]];
    }
    if (indexPath.section == 1) {
        [cell resetViewWithDic:[self.subcategoryArray2 objectAtIndex:indexPath.row]];
    }
    if (indexPath.section == 2) {
        [cell resetViewWithDic:[self.subcategoryArray3 objectAtIndex:indexPath.row]];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = kScreenWidth/3-10;
    return CGSizeMake(width, 80);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SimpleHeaderCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"testCategoryHeader" forIndexPath:indexPath];
    [cell resetViewWithInfo:[self.categoryArray objectAtIndex:indexPath.section]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 60);
}



@end
