//
//  HotViewController.h
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "BaseViewController.h"
#import "AppModel.h"
#import "HotTableViewCell.h"
#import "DetailViewController.h"
@interface HotViewController : BaseViewController

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *picsArr;
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property(nonatomic)BOOL isRefresh;
@property(nonatomic)BOOL isLoadMore;
@property (nonatomic) NSInteger count;

@property (nonatomic) NSInteger page;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIPageControl *pageControl;
- (void)downloadWithUrl:(NSString *)url;


@end
