//
//  TabbarViewController.m
//  tiku
//
//  Created by aaa on 2017/4/26.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "TabbarViewController.h"
#import "TestLibraryViewController.h"
#import "ClassRoomViewController.h"
#import "CommunityViewController.h"
#import "MainViewController.h"
#import "TikuViewController.h"

@interface TabbarViewController ()<UITabBarControllerDelegate>

@property (nonatomic,strong)TikuViewController *tikuViewController;
//@property (nonatomic, strong)TestLibraryViewController *tikuViewController;
@property (nonatomic, strong)ClassRoomViewController *classRoomVC ;
@property (nonatomic, strong)CommunityViewController *communityVC;
@property (nonatomic, strong)MainViewController *mainVC;

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.delegate = self;
    [self setupChildViewControllers];
    
}

#pragma mark - ui setup
- (void)setupChildViewControllers
{
    self.mainVC = [[MainViewController alloc] init];
    self.tikuViewController = [[TikuViewController alloc] init];
    self.classRoomVC = [[ClassRoomViewController alloc] init];
    self.communityVC = [[CommunityViewController alloc] init];
    
    
    /*    self.courseCategoryViewController = [[AllCourseViewController alloc] init];
     self.courseCategoryViewController.intoType = IntoPageTypeAllCourse;*/
    UINavigationController *testNavigation = [[UINavigationController alloc] initWithRootViewController:self.tikuViewController];
    testNavigation.tabBarItem.image = [UIImage imageNamed:@"题库50-50-a"];
    testNavigation.tabBarItem.selectedImage = [UIImage imageNamed:@"题库act50-50-b"];
    testNavigation.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    testNavigation.tabBarItem.title = @"题库";
    
    UINavigationController *classroomNavigation = [[UINavigationController alloc] initWithRootViewController:self.classRoomVC];
    classroomNavigation.tabBarItem.image = [UIImage imageNamed:@"课程50-50-a"];
    classroomNavigation.tabBarItem.selectedImage = [UIImage imageNamed:@"课程act50-50-b"];
    classroomNavigation.tabBarItem.title = @"课堂";
    
    UINavigationController *communicationNavigation = [[UINavigationController alloc] initWithRootViewController:self.communityVC];
    communicationNavigation.tabBarItem.image = [UIImage imageNamed:@"交流50-50-a"];
    communicationNavigation.tabBarItem.selectedImage = [UIImage imageNamed:@"交流act50-50-b"];
    communicationNavigation.tabBarItem.title = @"交流";
    
    UINavigationController *settingNavigation = [[UINavigationController alloc] initWithRootViewController:self.mainVC];
    settingNavigation.tabBarItem.image = [UIImage imageNamed:@"me50-50-a"];
    settingNavigation.tabBarItem.selectedImage = [UIImage imageNamed:@"me-act50-50-b"];
    settingNavigation.tabBarItem.title = @"我的";
    
    self.viewControllers = @[testNavigation,classroomNavigation,communicationNavigation,settingNavigation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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
