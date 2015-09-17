//
//  TechnologyAndProductAndCarViewController.m
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "TechnologyAndProductAndCarViewController.h"
#define kCellId @"TPCTableViewCell"
@interface TechnologyAndProductAndCarViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

@end

@implementation TechnologyAndProductAndCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    [self createAFNetwork];
    
    
    self.isRefresh = NO;
    
    self.isLoadMore = NO;
    
    self.count = 0;
    
}

//结束刷新
- (void)endRefreshing
{
    if (self.isRefresh) {
        
        self.isRefresh = NO;
        
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadMore) {
        
        self.isLoadMore = NO;
        
        [self.tableView footerEndRefreshing];
    }
}

#pragma mark  -- AFNet

- (void)createAFNetwork {
    self.dataArr = [[NSMutableArray alloc]init];
    //创建 AF
    self.manager = [AFHTTPRequestOperationManager manager];
    //返回 二进制数据不解析
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}
- (void)downloadWithUrl:(NSString *)url {
    
    __weak typeof(self) weakSelf = self;
    
    //显示下载特效
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"正在下载" status:@"loading...."];
    
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            if (weakSelf.count == 0) {
                [weakSelf.dataArr removeAllObjects];
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *data =dict[@"data"];
            NSArray *array = data[@"listData"];
            for (NSDictionary *listDict in array){
                AppModel *model =[[AppModel alloc]init];
                model.title = listDict[@"title"];
                model.contentUrl = listDict[@"contentUrl"];
                model.brief = listDict[@"brief"];
                NSDictionary *indexPic = listDict[@"indexPic"];
                model.host = indexPic[@"host"];
                model.dir = indexPic[@"dir"];
                model.filepath = indexPic[@"filepath"];
                model.filename = indexPic[@"filename"];
                NSDictionary *extendValues = listDict[@"extendValues"];
                model.author = extendValues[@"author"];
                model.source = extendValues[@"source"];
                model.clickNum = [NSString stringWithFormat:@"%@",extendValues[@"clickNum"]];
                [weakSelf.dataArr addObject:model];
            }
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshing];
            [MMProgressHUD dismissWithSuccess:@"恭喜你" title:@"下载成功"];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf endRefreshing];
        [MMProgressHUD dismissWithError:@"下载失败" title:@"警告"];
    }];
    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 94-49) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TPCTableViewCell" bundle:nil] forCellReuseIdentifier:kCellId];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TPCTableViewCell" forIndexPath:indexPath];
    AppModel *model = self.dataArr[indexPath.row];
    [cell showDataWithModel:model];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 321;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIWebView *webView = [[UIWebView alloc]init];
    [(UIScrollView *)[[webView subviews] objectAtIndex:0]setBounces:NO];
    [webView setScalesPageToFit:YES];
    
    webView.delegate = self;
    DetailViewController *detail = [[DetailViewController alloc]init];
    
    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 150);
    
    AppModel *model = self.dataArr[indexPath.row];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:model.contentUrl]];
    
    [webView loadRequest:request];
    
    [detail.view addSubview:webView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    
    UIView *view = [[UIView alloc]init];
    
    view.frame = label.frame;
    
    label.backgroundColor = [UIColor grayColor];
    
    label.text = @"掌上资讯";
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:label];
    
    [detail.view  addSubview:view];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark --  UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType==UIWebViewNavigationTypeLinkClicked)//判断是否是点击链接
    {
        return NO;
    }
    else{
        return YES;
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'black'"];
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
