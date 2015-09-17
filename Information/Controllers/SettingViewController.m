//
//  SettingViewController.m
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createHeaderView];
    [self createTableView];
    
}

-(void)createHeaderView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    
    imageView.image = [UIImage imageNamed:@"uinavigationbar"];
    
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button.frame = CGRectMake(5, 20, 44, 44);
    
    [button setBackgroundImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:button];
    
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(0, LeftDistance+5, self.view.bounds.size.width, Default);
    
    label.text = @"我的设置";
    
    label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    
    
}

-(void)btnClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createTableView {
    self.dataArr = [NSMutableArray arrayWithObjects:@"天气",@"我的收藏",@"我的分享",@"清除缓存",@"意见反馈",@"关于我们", nil];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 300) style:UITableViewStylePlain];
    self.tableView.dataSource =self;
    self.tableView.delegate =self;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    cell.textLabel.text=[self.dataArr objectAtIndex:indexPath.row];
    //给tableview上的字体的颜色设置为白色
    cell.textLabel.textColor=[UIColor blackColor];
    //设置字体的大小
    cell.textLabel.font=[UIFont fontWithName:@"Khmer" size:16];
    //cell.backgroundColor=[UIColor clearColor];
    //给每个cell上都填一个右箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 1://我的收藏
        {
           
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3://清除缓存
        {
            //缓存 一般 都是一些 缓存图片 或者 是自己缓存的一些数据
            //SDWebImage  下载图片 会做缓存--->()
            //NSLog(@"%@",NSHomeDirectory());
            //
            NSUInteger fileSize = [[SDImageCache sharedImageCache] getSize];
            //换算成 M
            CGFloat size = fileSize/1024.0/1024.0;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否要删除缓存" message:[NSString stringWithFormat:@"缓存大小 %.2fM",size] preferredStyle:UIAlertControllerStyleActionSheet];
            [ alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                //删除的时候回调这个block
                //删除 sd 的缓存
                [[SDImageCache sharedImageCache] clearMemory];
                [[SDImageCache sharedImageCache] clearDisk];
                
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
            break;
        case 4:
        {
            
        }
            
            break;
        case 5:
        {
            UIViewController *vc = [[UIViewController alloc]init];
            
            vc.view.backgroundColor = [UIColor whiteColor];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 160)];
            
            label.text = @"        掌上资讯集合各大科技资讯类网站的头条新闻 , 主要是关于科技 , IT , 汽车和互联网的资讯等等。掌上资讯致力于发现创新科技 , 前沿技术 , 成为深受广大用户喜爱的交流平台。";
            
            label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:16];
            
            label.numberOfLines = 0;
            
            [vc.view addSubview:label];
            
            //设置弹出模式
            vc.modalPresentationStyle = UIModalPresentationPopover;//气泡弹出
            //设置弹出的大小
            vc.preferredContentSize = CGSizeMake(200, 160);
            
            //获取视图控制器的 泡泡控制器
            UIPopoverPresentationController *popVC = vc.popoverPresentationController;
            
            //设置泡泡 从哪个视图弹出
            vc.popoverPresentationController.sourceView = self.view;
            
            //设置泡泡弹出的位置
            vc.popoverPresentationController.sourceRect = CGRectMake(150, 220, 100, 100);
            
            //设置三角标的方向
            popVC.permittedArrowDirections = UIPopoverArrowDirectionUp;
            
            //设置代理
            popVC.delegate = self;
            //弹出气泡
            [self presentViewController:vc animated:YES completion:nil];
            
        }
            break;
        default:
            break;
            
    }
    
}

#pragma mark - UIPopoverPresentationControllerDelegate协议方法
//如果要想在iPhone上也能弹出泡泡的样式必须要实现下面协议的方法
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}

- (void)itemClick:(UIBarButtonItem *)item {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    //弹出模式
    vc.modalPresentationStyle = UIModalPresentationPopover;
    //泡泡内容的大小
    vc.preferredContentSize = CGSizeMake(200, 200);
    //获取泡泡
    UIPopoverPresentationController *popVC = vc.popoverPresentationController;
    //从item 弹出
    popVC.barButtonItem = item;
    popVC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popVC.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
    
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
