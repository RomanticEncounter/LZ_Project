//
//  SecondViewController.m
//  LZ_Demo
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "SecondViewController.h"
#import "CommonSingleton.h"
#import "ClockTableViewCell.h"
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myAlarmClockTableView ;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"闹钟";
    self.view.backgroundColor = [UIColor whiteColor];
    
    myAlarmClockTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    myAlarmClockTableView.dataSource = self ;
    myAlarmClockTableView.delegate = self ;
    myAlarmClockTableView.rowHeight = 100 ;
    myAlarmClockTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:myAlarmClockTableView];
    [myAlarmClockTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left).with.offset(0.0f);
         make.right.equalTo(self.view.mas_right).with.offset(0.0f);
         make.top.equalTo(self.view.mas_top).with.offset(0.0f);
         make.bottom.equalTo(self.view.mas_bottom).offset(0.0f);
     }];
    
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItemClick:)];
    leftBarItem.tintColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = leftBarItem ;
    
    
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemClick:)];
    rightBarItem.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = rightBarItem ;
    
    [myAlarmClockTableView registerNib:[UINib nibWithNibName:@"ClockTableViewCell" bundle:nil] forCellReuseIdentifier:@"clock"];
    
    [LZLocalNotificationSingleton registLocalNotificationAction];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clock" forIndexPath:indexPath];
    
    return cell ;
}


- (void)editItemClick:(UIBarButtonItem *)edit
{
    
}
- (void)addItemClick:(UIBarButtonItem *)add
{
//    AddClockViewController *addVC = [[AddClockViewController alloc]init];
//    [self.navigationController pushViewController:addVC animated:YES];
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
