//
//  CarViewController.m
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "CarViewController.h"

@interface CarViewController ()

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    [self downloadWithUrl:[NSString stringWithFormat:kCarUrl,self.count]];
    [self createDropDownRefresh];
    
    [self createPullOnLoading];
    //测试2
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"widgettop_bg_big_1"] forBarMetrics:UIBarMetricsDefault];
    
}


-(void)createDropDownRefresh
{
    __weak typeof (self)weakSelf = self;
    
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefresh) {
            return ;
        }
        weakSelf.isRefresh = YES;
        weakSelf.count = 0;
        [weakSelf downloadWithUrl:[NSString stringWithFormat:kCarUrl,weakSelf.count]];
    }];
    
}

-(void)createPullOnLoading
{
    __weak typeof(self)weakSelf = self;
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.count += 15;
        [weakSelf downloadWithUrl:[NSString stringWithFormat:kCarUrl,weakSelf.count]];
    }];
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
