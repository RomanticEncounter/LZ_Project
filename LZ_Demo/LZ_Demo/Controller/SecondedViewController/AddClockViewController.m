//
//  AddClockViewController.m
//  LZ_Demo
//
//  Created by mac on 16/8/10.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "AddClockViewController.h"
#import "CommonSingleton.h"
@interface AddClockViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * addTableView ;
    UIView * headView ;
    UIDatePicker * datePicker ;
}

@end

@implementation AddClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    addTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    addTableView.dataSource = self ;
    addTableView.delegate = self ;
    addTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:addTableView];
    [addTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0.0f);
        make.top.equalTo(self.view.mas_top).with.offset(0.0f);
        make.right.equalTo(self.view.mas_right).with.offset(0.0f);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0f);
    }];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithTitle:@"存储" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemClick:)];
    self.navigationItem.rightBarButtonItem = saveItem ;
    
}
#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1 ;
    }
    return 3 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    switch (indexPath.section)
    {
        case 0:
        {
            headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_WIDTH, 200)];
            [cell.contentView addSubview:headView];
            
            datePicker = [[UIDatePicker alloc]init];
            datePicker.frame = CGRectMake(0, 0, S_WIDTH, 200);
            datePicker.datePickerMode = UIDatePickerModeTime ;
            
            [headView addSubview:datePicker];
        }
            break;
        case 1:
        {
            
        }
            break;
        default:
            break;
    }
    return cell ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 200 ;
    }
    return 44 ;
}
- (void)saveItemClick:(UIBarButtonItem *)saveItem
{
    //小时
    NSDateFormatter *hours =[[NSDateFormatter alloc]init];
    
    [hours setDateFormat:@"hh"];
    //分钟
    NSDateFormatter *minutes = [[NSDateFormatter alloc]init];
    
    [minutes setDateFormat:@"mm"];
    
    //小时
    NSString *hoursString = [hours stringFromDate:datePicker.date];
    //分钟
    NSString *minuteString = [minutes stringFromDate:datePicker.date];
    
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
