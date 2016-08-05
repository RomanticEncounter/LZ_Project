//
//  FirstViewController.m
//  LZ_Demo
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "FirstViewController.h"
#import "LZNetworkSingleton.h"
#import "Masonry.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FirstTableViewCell.h"
#import "FirstModel.h"
#import "FirstDetailViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView ;
    NSMutableArray *dataSourceArray ;
}

@end

@implementation FirstViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImage *image = [UIImage imageNamed:@"Icon"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, self.navigationController.navigationBar.bounds.size.height)];
    imageView.image = image ;
    imageView.contentMode = UIViewContentModeScaleAspectFit ;//设置
    self.navigationItem.titleView = imageView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    UIImage *image = [UIImage imageNamed:@"Icon"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, self.navigationController.navigationBar.bounds.size.height)];
    imageView.image = image ;
    imageView.contentMode = UIViewContentModeScaleAspectFit ;//设置
    self.navigationItem.titleView = imageView;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    myTableView.dataSource = self ;
    myTableView.delegate = self ;
    [self.view addSubview:myTableView];
    
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
    
    cell.model = dataSourceArray[indexPath.row];
    return cell ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(FirstTableViewCell*cell)
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
    [self.navigationController pushViewController:detailVC animated:YES];
}
/**
 *  请求
 */
- (void)HttpRequest
{
    [LZNetworkSingleton AddValueWithGET:@"http://apis.baidu.com/qunartravel/travellist/travellist?page=1" addAPIKEY:@"936b24796528abb71d4f5c8996e37598" success:^(NSMutableDictionary *dic)
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
     }
    fail:^(NSError *error)
     {
         NSLog(@"%@",error);
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
