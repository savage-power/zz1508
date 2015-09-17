//
//  LQTabBarViewController.m
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "LQTabBarViewController.h"
#import "WMPageController.h"
#import "LQDetailTitleManager.h"
#import "SettingViewController.h"
#import "AppDelegate.h"
@interface LQTabBarViewController () {
    
    WMPageController *_pageVC;
    NSMutableArray *_dataArr;
    
}

@property(nonatomic,strong)WMPageController *pageVC;

@property(nonatomic,strong) NSArray *hotTArray;
@property(nonatomic,strong) NSArray *hotCArray;

@property(nonatomic,strong) NSArray *informationTArray;
@property(nonatomic,strong) NSArray *informationCArray;

@property(nonatomic,strong) NSArray *technologyTArray;
@property(nonatomic,strong) NSArray *technologyCArray;

@property(nonatomic,strong) NSArray *productTArray;
@property(nonatomic,strong) NSArray *productCArray;

@property(nonatomic,strong) NSArray *lifeTArray;
@property(nonatomic,strong) NSArray *lifeCArray;

@property(nonatomic,strong) NSArray *allTArray;
@property(nonatomic,strong) NSArray *allCArray;


@end

@implementation LQTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDetailControllers];
    
    [self createViewControllers];
    
}
- (void)createDetailControllers {
    
    self.hotTArray=@[@"商业",@"互联",@"观点"];
    self.hotCArray=@[@"BusinessViewController",@"InternetViewController",@"PointViewController"];
    
    self.technologyTArray=@[@"科技"];
    self.technologyCArray=@[@"TechnologyViewController"];
    
    self.productTArray = @[@"产品"];
    self.productCArray=@[@"ProductViewController"];
    
    self.informationTArray = @[@"O2O",@"金融",@"教育",@"专栏",@"Fun",@"硬件"];
    self.informationCArray =@[@"O2OViewController",@"FinancialViewController",@"EducationViewController",@"ColumnViewController",@"FunViewController",@"HardwareViewController"];
    
    self.lifeTArray = @[@"汽车"];
    self.lifeCArray = @[@"CarViewController"];
    
    
    self.allTArray =@[self.hotTArray,self.technologyTArray,self.productTArray,self.informationTArray,self.lifeTArray];
    self.allCArray=@[self.hotCArray,self.technologyCArray,self.productCArray,self.informationCArray,self.lifeCArray];
}

- (void)createViewControllers {
    
    NSArray *titleArr=@[@"热点",@"科技聚焦",@"产品资讯",@"前沿",@"汽车之家"];
    NSArray *nameArr =@[@"热点",@"科技",@"产品",@"资讯",@"汽车"];
    
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0 ; i < titleArr.count; i++) {
        
        self.pageVC = [[LQDetailTitleManager sharedInstance]addDetailWithControllersArray:self.allCArray[i] titles:self.allTArray[i]];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.pageVC];
        
        [self.pageVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"uinavigationbar"] forBarMetrics:UIBarMetricsDefault];
        self.pageVC.navigationItem.title=titleArr[i];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
        label.text =titleArr[i];
        self.pageVC.navigationItem.titleView=label;
        
        self.pageVC.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"menusettings"] style:UIBarButtonItemStyleDone target:self action:@selector(itemClick:)];
        
        
        nav.tabBarItem.title=nameArr[i];
        
        nav.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar%ld",i+1]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar%ldselect",i+1]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBar.tintColor=[UIColor redColor];
        
        [dataArr addObject:nav];
        
    }
    self.viewControllers=dataArr;
}

-(void)itemClick:(UIBarButtonItem *)item
{
    SettingViewController *setting = [[SettingViewController alloc]init];
    
    [self presentViewController:setting animated:YES completion:nil];
    
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
