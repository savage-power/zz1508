//
//  InformationViewController.h
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "BaseViewController.h"
#import "AppModel.h"
#import "HotTableViewCell.h"
#import "DetailViewController.h"
@interface InformationViewController : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property(nonatomic)BOOL isRefresh;
@property(nonatomic)BOOL isLoadMore;
@property (nonatomic) NSInteger count;

- (void)downloadWithUrl:(NSString *)url;


@end
