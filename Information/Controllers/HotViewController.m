//
//  HotViewController.m
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "HotViewController.h"
#define kCellId @"HotTableViewCell"

@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate>

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self addTimer];
    
    [self createTableView];
    [self createAFNetwork];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    self.picsArr = [[NSMutableArray alloc]init];
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
            NSDictionary *compData = data[@"compData"];
            NSArray *array = compData[@"5755"];
            for (NSDictionary *headDict in array){
                AppModel *model =[[AppModel alloc]init];
                model.title = headDict[@"title"];
                model.contentUrl = headDict[@"contentUrl"];
                NSDictionary *indexPic = headDict[@"indexPic"];
                model.host = indexPic[@"host"];
                model.dir = indexPic[@"dir"];
                model.filepath = indexPic[@"filepath"];
                model.filename = indexPic[@"filename"];
                model.button = [[UIButton alloc]init];
                [model.button sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",model.host,model.dir,model.filepath,model.filename]]forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"card_bg2"]];
                [weakSelf.picsArr addObject:model];
                
            }
            
            NSArray *array1 = data[@"listData"];
            for (NSDictionary *listDict in array1){
                AppModel *model =[[AppModel alloc]init];
                model.title = listDict[@"title"];
                model.contentUrl = listDict[@"contentUrl"];
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
            [weakSelf createHeadScrollView];
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshing];
            [MMProgressHUD dismissWithSuccess:@"恭喜你" title:@"下载成功"];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf endRefreshing];
        [MMProgressHUD dismissWithError:@"下载失败" title:@"警告"];
    }];
    
}

- (void)createHeadScrollView {
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width * self.picsArr.count, 150)];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.picsArr.count,150);
    self.scrollView.delegate=self;
    self.scrollView.pagingEnabled = YES;
    for (NSInteger i = 0; i < self.picsArr.count; i ++) {
        AppModel *model = self.picsArr[i];
        
        model.button.frame = CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, 150);
        [model.button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        model.button.tag = 100 +i;
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, CGRectGetMaxY(model.button.frame)- 20, self.view.bounds.size.width, 20);
        label.backgroundColor=[UIColor clearColor];
        label.text = model.title;
        label.textColor =[UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        [model.button addSubview:label];
        [self.scrollView addSubview:model.button];
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.scrollView.width-85,self.scrollView.height-40 , 80, 30)];
        self.pageControl.numberOfPages = self.picsArr.count;
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.defersCurrentPageDisplay = YES;
        self.pageControl.enabled = NO;
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        
    }
    self.tableView.tableHeaderView =self.scrollView;
}

- (void)btnClick:(UIButton *)button {
    UIWebView *webView = [[UIWebView alloc]init];
    
    [(UIScrollView *)[[webView subviews] objectAtIndex:0]setBounces:NO];
    webView.delegate = self;
    DetailViewController *detail = [[DetailViewController alloc]init];
    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 150);
    AppModel *model = [[AppModel alloc]init];
    for (NSInteger i = 0; i< self.picsArr.count;i++) {
        if (button.tag == i+100) {
            
            model = self.picsArr[i];
        }
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.contentUrl]];
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

//添加定时器
- (void)addTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
//移除定时器
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)nextImage {
    
    // 1.增加pageControl的页码
    self.page = 0;
    if (self.pageControl.currentPage == self.picsArr.count -1 ) {
        self.page = 0;
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    } else {
        self.page =(int)self.pageControl.currentPage + 1;
    }
    
    // 2.计算scrollView滚动的位置
    CGFloat offsetX = self.page * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
    
}

#pragma mark - 代理方法
/**
 *  当scrollView正在滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 根据scrollView的滚动位置决定pageControl显示第几页
    CGFloat scrollW = self.scrollView.frame.size.width;
    int page = (self.scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page;
}

/**
 *  开始拖拽的时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器(一旦定时器停止了,就不能再使用)
    [self removeTimer];
}

/**
 *  停止拖拽的时候调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开启定时器
    [self addTimer];
}


- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 94-49) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HotTableViewCell" bundle:nil] forCellReuseIdentifier:kCellId];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotTableViewCell" forIndexPath:indexPath];
    AppModel *model = self.dataArr[indexPath.row];
    [cell showDataWithModel:model];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIWebView *webView = [[UIWebView alloc]init];
    [(UIScrollView *)[[webView subviews] objectAtIndex:0]setBounces:NO];

    webView.delegate = self;
    
    //webView.dataDetectorTypes = UIDataDetectorTypeNone;
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
