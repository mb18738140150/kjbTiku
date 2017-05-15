//
//  ClassRoomViewController.m
//  tiku
//
//  Created by aaa on 2017/4/26.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "ClassRoomViewController.h"
#import "UIMacro.h"
#import "HYSegmentedControl.h"
#import "ClassroomVideoTableViewCell.h"
#import "UIMacro.h"
#import "ClassroomLivingTableViewCell.h"

#define kClassroomcellId @"ClassroomVideoTableViewCellID"
#define kClassroomLivingcellId @"ClassroomLivingTableViewCellID"

@interface ClassRoomViewController ()<HYSegmentedControlDelegate, UITableViewDelegate, UITableViewDataSource>

/**
 *  视频和直播页面切换segment
 */
@property (nonatomic, strong)HYSegmentedControl * segmentC;

@property (nonatomic, strong)UIScrollView * scrollView;

@property (nonatomic, strong)UITableView *videoTableview;
@property (nonatomic, strong)UITableView *livingTableview;

@end

@implementation ClassRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigationViewSetup];
    
    [self segmentSetup];
    [self tableviewSetup];
}

- (void)segmentSetup
{
    self.segmentC = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"视频", @"直播"] delegate:self];
    [self.view addSubview:self.segmentC];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"课堂";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonNavigationBarTextColor,NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
}

- (void)tableviewSetup
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 42, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - 42)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - 42);
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    
    
    self.videoTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - 42) style:UITableViewStylePlain];
    self.videoTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.videoTableview.delegate = self;
    self.videoTableview.dataSource = self;
    self.videoTableview.backgroundColor = UIRGBColor(230, 230, 230);
    
    [self.videoTableview registerNib:[UINib nibWithNibName:@"ClassroomVideoTableViewCell" bundle:nil] forCellReuseIdentifier:kClassroomcellId];
    [self.scrollView addSubview:self.videoTableview];
    
    self.livingTableview = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - 42) style:UITableViewStylePlain];
    self.livingTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.livingTableview.delegate = self;
    self.livingTableview.dataSource = self;
    self.livingTableview.backgroundColor = UIRGBColor(230, 230, 230);
    
    [self.livingTableview registerNib:[UINib nibWithNibName:@"ClassroomLivingTableViewCell" bundle:nil] forCellReuseIdentifier:kClassroomLivingcellId];
    [self.scrollView addSubview:self.livingTableview];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.videoTableview]) {
        ClassroomVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kClassroomcellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reset:indexPath.row];
        return cell;
    }else
    {
        ClassroomLivingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kClassroomLivingcellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 99;
}

#pragma mark - HYSegmentedControl 代理方法
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * _scrollView.hd_width, 0) animated:YES];
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
