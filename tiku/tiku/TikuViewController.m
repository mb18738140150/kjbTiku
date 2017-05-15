//
//  TikuViewController.m
//  tiku
//
//  Created by aaa on 2017/5/9.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "TikuViewController.h"
#import "ContentTableViewDataSource.h"
#import "SVProgressHUD.h"
#import "ImageManager.h"
#import "MJRefresh.h"
#import "CommonMacro.h"
#import "UIMacro.h"
#import "MainViewMacro.h"
#import "UIUtility.h"
#import "CategoryView.h"

@interface TikuViewController ()<UITableViewDelegate,ImageModule_BannerProtocol>

@property (nonatomic,strong)    UITableView                     *contentTableView;
@property (nonatomic, strong)ContentTableViewDataSource *contentTableSource;
@property (nonatomic,strong)    NSArray                         *categoryArray;


@end

@implementation TikuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tableDataSetup];
    
    [self navigationViewSetup];
    [self contentViewInit];
    
//    [self addNotifications];
    
    [self startRequest];
    
}

- (void)tableDataSetup
{
    self.categoryArray = @[@{kCourseCategoryName:@"章节试题",
                             kCourseCategoryCoverUrl:@"homeIcon1.png",
                             kCourseCategoryId:@(52)},
                           @{kCourseCategoryName:@"模拟题",
                             kCourseCategoryCoverUrl:@"homeIcon2.png",
                             kCourseCategoryId:@(62)},
                           @{kCourseCategoryName:@"易错题",
                             kCourseCategoryCoverUrl:@"homeIcon3.png",
                             kCourseCategoryId:@(44)},
                           @{kCourseCategoryName:@"收藏题",
                             kCourseCategoryCoverUrl:@"homeIcon4.png",
                             kCourseCategoryId:@(46)},
                           @{kCourseCategoryName:@"错题本",
                             kCourseCategoryCoverUrl:@"homeIcon5.png",
                             kCourseCategoryId:@(66)},
                           @{kCourseCategoryName:@"巩固模考",
                             kCourseCategoryCoverUrl:@"homeIcon6.png",
                             kCourseCategoryId:@(61)}];
}

- (void)startRequest
{
    [SVProgressHUD show];
    [[ImageManager sharedManager] didRequestBannerImagesWithNotifiedObject:self];
    
}

- (void)requestEnd
{
    [self.contentTableView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
}

- (void)contentViewInit
{
    CGRect tableViewRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight);
    self.contentTableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    self.contentTableSource = [[ContentTableViewDataSource alloc] init];
    self.contentTableView.delegate = self;
    self.contentTableSource.catoryDataSourceArray = self.categoryArray;
    self.contentTableView.dataSource = self.contentTableSource;
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self startRequest];
    }];
    
    [self.view addSubview:self.contentTableView];
}

#pragma mark - ui
- (void)navigationViewSetup
{
    self.navigationItem.title = @"首  页";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonNavigationBarTextColor,NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
    CategoryView *cateView = [[CategoryView alloc] initWithFrame:CGRectMake(0,0,40,30)];
    cateView.pageType = PageMessage;
    cateView.categoryName = @"消息";
    cateView.categoryCoverUrl = @"courseicon";
    cateView.backgroundColor = [UIColor clearColor];
    [cateView setupNaviContents];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:cateView];
    self.navigationItem.rightBarButtonItem = item;
    
    CategoryView *leftcateView = [[CategoryView alloc] initWithFrame:CGRectMake(0,0,40,30)];
    leftcateView.pageType = PageLeft;
    leftcateView.categoryName = @"";
    leftcateView.categoryCoverUrl = @"courseicon";
    leftcateView.backgroundColor = [UIColor clearColor];
    [leftcateView setupNaviContents];
    UIBarButtonItem * leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftcateView];
    self.navigationItem.leftBarButtonItem = leftitem;
    
}
#pragma mark - banner delegate
- (void)didBannerRequestSuccess
{
    [self requestEnd];
    [self.contentTableView reloadData];
}

- (void)didBannerRequestFailed
{
    [self requestEnd];
    [SVProgressHUD showErrorWithStatus:@"网络连接失败，请稍后再试"];
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cellHeight = kCellHeightOfBanner;
    }
    if (indexPath.section == 1) {
        /*        if (self.categoryArray.count % 4 == 0) {
         return self.categoryArray.count/4 * kCellHeightOfCategoryImage;
         }else{
         return (self.categoryArray.count/4 + 1) * kCellHeightOfCategoryImage;
         }*/
        return 2 * kCellHeightOfCategoryView + 30;
        
    }
    if (indexPath.section == 2 ) {
        cellHeight = 50;
    }
    
    if (indexPath.section == 3 ) {
        
        return 50;
    }
    return cellHeight;
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
