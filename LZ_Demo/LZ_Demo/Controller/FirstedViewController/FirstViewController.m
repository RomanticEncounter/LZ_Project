//
//  FirstViewController.m
//  LZ_Demo
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "FirstViewController.h"
#import "LZNetworkSingleton.h"
#import "FirstTableViewCell.h"
#import "FirstModel.h"
#import "FirstDetailViewController.h"
#import "CommonSingleton.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView ;
    NSMutableArray *dataSourceArray ;
    NSInteger downFresh ;
    UIImageView * checkView ;
}

@end

@implementation FirstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    /**
     *  导航栏上的图片
     */
    UIImage *image = [UIImage imageNamed:@"QNW"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, self.navigationController.navigationBar.bounds.size.height)];
    imageView.image = image ;
    imageView.contentMode = UIViewContentModeScaleAspectFit ;//设置
    self.navigationItem.titleView = imageView;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    
    downFresh = 1 ;
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    myTableView.dataSource = self ;
    myTableView.delegate = self ;
    [self.view addSubview:myTableView];
    myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [dataSourceArray removeAllObjects];
        downFresh = 1 ;
        [self HttpRequest];
        [myTableView.mj_header endRefreshing];
    }];
    myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        downFresh = downFresh + 1 ;
        if (downFresh > 100)
        {
            downFresh = 100 ;
        }
        [self HttpRequest];
        [myTableView.mj_footer endRefreshing];
    }];
    
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).with.offset(0.0f);
         make.right.equalTo(self.view.mas_right).with.offset(0.0f);
         make.top.equalTo(self.view.mas_top).with.offset(0.0f);
         make.bottom.equalTo(self.view.mas_bottom).offset(0.0f);
     }];
    
    [myTableView registerNib:[UINib nibWithNibName:@"FirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self HttpRequest];
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSourceArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[FirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.checkButton addTarget:self action:@selector(tapCilck:) forControlEvents:UIControlEventTouchUpInside];
    cell.checkButton.tag = indexPath.row ;
    cell.model = dataSourceArray[indexPath.row];
    return cell ;
}
/**
 *  自适应高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
/**
 *  计算
 */
//    FirstModel * model = dataSourceArray[indexPath.row];
//    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    [cell cellAutoLayoutHeight:model.detailText];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height;
    
/**
 *  UITableView+FDTemplateLayoutCell
 */
    return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(FirstTableViewCell *cell)
    {
        cell.model = dataSourceArray[indexPath.row];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FirstDetailViewController * detailVC = [[FirstDetailViewController alloc]init];
    FirstModel *model = dataSourceArray[indexPath.row];
    detailVC.URL = model.pushURL ;
    detailVC.title = model.title ;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - 数据请求
/**
 *  请求
 */
- (void)HttpRequest
{
    [CommonSingleton HUDloadingWithString:@"正在努力加载中..."];
    NSString *url = [NSString stringWithFormat:@"http://apis.baidu.com/qunartravel/travellist/travellist?page=%ld",(long)downFresh];
    [LZNetworkSingleton AddValueWithGET:url addAPIKEY:@"936b24796528abb71d4f5c8996e37598" success:^(NSMutableDictionary *dic)
     {
         NSArray *arr = dic[@"data"][@"books"] ;
         for (int i = 0 ; i < arr.count; i++)
         {
             FirstModel *model = [[FirstModel alloc]init];
             model.pushURL = arr[i][@"bookUrl"];
             model.backGroundImg = arr[i][@"headImage"];
             model.userHeadImg = arr[i][@"userHeadImg"];
             model.userName = arr[i][@"userName"];
             model.time = arr[i][@"startTime"];
             model.title = arr[i][@"title"];
             model.detailText = arr[i][@"text"];
             [dataSourceArray addObject:model];
         }
         if (myTableView)
         {
             [myTableView reloadData];
         }
         [CommonSingleton HUDdismiss];
     }
    fail:^(NSError *error)
     {
         NSLog(@"%@",error);
         [CommonSingleton HUDdismiss];
     }];

}
#pragma mark - 点击图片可查看
/**
 *  查看图片
 */
- (void)tapCilck:(UIButton *)tap
{
    FirstModel *model = dataSourceArray[tap.tag];
    checkView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_WIDTH, S_HEIGHT)];
    checkView.userInteractionEnabled = YES ;
    [checkView sd_setImageWithURL:[NSURL URLWithString:model.backGroundImg] placeholderImage:nil];
    checkView.contentMode = UIViewContentModeScaleToFill;
    checkView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [[UIApplication sharedApplication].keyWindow addSubview:checkView];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    effectView.frame = [UIApplication sharedApplication].keyWindow.frame ;
    [checkView addSubview:effectView];
    
    UIImageView * checkImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S_WIDTH, myTableView.bounds.size.height)];
    checkImgView.userInteractionEnabled = YES ;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick:)];
    [checkImgView addGestureRecognizer:tapGesture];
    checkImgView.contentMode = UIViewContentModeScaleAspectFit;
    checkImgView.autoresizesSubviews = YES;
    checkImgView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [checkImgView sd_setImageWithURL:[NSURL URLWithString:model.backGroundImg] placeholderImage:nil];
    
    [checkView addSubview:checkImgView];
    
}
#pragma mark - 取消手势
- (void)tapGestureClick:(UITapGestureRecognizer *)tap
{
    [checkView removeFromSuperview];
    checkView = nil ;
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
