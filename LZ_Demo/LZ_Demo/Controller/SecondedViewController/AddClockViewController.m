//
//  AddClockViewController.m
//  LZ_Demo
//
//  Created by mac on 16/8/10.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "AddClockViewController.h"
#import "CommonSingleton.h"
@interface AddClockViewController ()<UIPickerViewDelegate>
{
//    UITableView * addTableView ;
    UIDatePicker * datePicker ;
    UILabel *secondsLabel ;//秒
    UILabel *minutesLabel ;//分
    UILabel *hoursLabel ;//小时
    UILabel *daysLabel ;//天
    UILabel *monthLabel ;//月
    UILabel *countdownLabel ;//倒计时
    NSDate *selectedDate ;
//    NSDateFormatter *formatter ;
    NSTimer *updateTimer;
}


@end

@implementation AddClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    addTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    addTableView.contentOffset = CGPointMake(0, 0);
//    addTableView.dataSource = self ;
//    addTableView.delegate = self ;
//    addTableView.tableFooterView = [[UIView alloc]init];
//    [self.view addSubview:addTableView];
//    [addTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(0.0f);
//        make.top.equalTo(self.view.mas_top).with.offset(0.0f);
//        make.right.equalTo(self.view.mas_right).with.offset(0.0f);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0f);
//    }];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithTitle:@"存储" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemClick:)];
    self.navigationItem.rightBarButtonItem = saveItem ;
    
    
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectZero];
//    datePicker.frame = CGRectMake(0, 0, S_WIDTH, 200);
    datePicker.datePickerMode = UIDatePickerModeDateAndTime ;
        [self.view addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0.0f);
        make.top.equalTo(self.view.mas_top).with.offset(50.0f);
        make.right.equalTo(self.view.mas_right).with.offset(0.0f);
        make.height.equalTo(@200);
    }];
    countdownLabel = [[UILabel alloc]init];//倒计时
    countdownLabel.text = @"距今还有 00 月 00 天 00 小时 00 分 00 秒";
    countdownLabel.textAlignment = NSTextAlignmentRight ;
    [self.view addSubview:countdownLabel];
    
    secondsLabel = [[UILabel alloc]init];
    secondsLabel.text = @"00 秒";
    secondsLabel.textAlignment = NSTextAlignmentRight ;
    [self.view addSubview:secondsLabel];
    
    minutesLabel = [[UILabel alloc]init];
    minutesLabel.text = @"00 分";
    minutesLabel.textAlignment = NSTextAlignmentRight ;
    [self.view addSubview:minutesLabel];
    
    hoursLabel = [[UILabel alloc]init];
    hoursLabel.text = @"00 小时";
    hoursLabel.textAlignment = NSTextAlignmentRight ;
    [self.view addSubview:hoursLabel];
    
    daysLabel = [[UILabel alloc]init];
    daysLabel.text = @"00 天";
    daysLabel.textAlignment = NSTextAlignmentRight ;
    [self.view addSubview:daysLabel];
    
    monthLabel = [[UILabel alloc]init];
    monthLabel.text = @"00 月";
    monthLabel.textAlignment = NSTextAlignmentRight ;
    [self.view addSubview:monthLabel];
    [self labelWithFrame];
}
- (void)labelWithFrame
{
    [countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0.0f);
        make.top.equalTo(datePicker.mas_bottom).with.offset(10.0f);
        make.right.equalTo(self.view.mas_right).with.offset(0.0f);
        make.height.equalTo(@50);
    }];
    [secondsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0.0f);
        make.top.equalTo(countdownLabel.mas_bottom).with.offset(10.0f);
        make.right.equalTo(self.view.mas_right).with.offset(0.0f);
        make.height.equalTo(@30);
    }];
    [minutesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0.0f);
        make.top.equalTo(secondsLabel.mas_bottom).with.offset(10.0f);
        make.right.equalTo(self.view.mas_right).with.offset(0.0f);
        make.height.equalTo(@30);
    }];
    [hoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0.0f);
        make.top.equalTo(minutesLabel.mas_bottom).with.offset(10.0f);
        make.right.equalTo(self.view.mas_right).with.offset(0.0f);
        make.height.equalTo(@30);
    }];
    [daysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0.0f);
        make.top.equalTo(hoursLabel.mas_bottom).with.offset(10.0f);
        make.right.equalTo(self.view.mas_right).with.offset(0.0f);
        make.height.equalTo(@30);
    }];
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0.0f);
        make.top.equalTo(daysLabel.mas_bottom).with.offset(10.0f);
        make.right.equalTo(self.view.mas_right).with.offset(0.0f);
        make.height.equalTo(@30);
    }];
    
    countdownLabel.textColor = [UIColor tealColor];
    secondsLabel.textColor = [UIColor moneyGreenColor];
    minutesLabel.textColor = [UIColor salmonColor];
    hoursLabel.textColor = [UIColor violetColor];
    daysLabel.textColor = [UIColor tealColor];
    monthLabel.textColor = [UIColor waveColor];
    
//    formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MMMM d号 HH:mm:ss"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        updateTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimeAgoLabels) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:updateTimer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop mainRunLoop] run];
    });

}



- (void)saveItemClick:(UIBarButtonItem *)saveItem
{
    
}
- (void)updateTimeAgoLabels
{
    selectedDate = datePicker.date ;
//    NSTimeInterval lefttime= [selectedDate timeIntervalSinceNow];
//    NSInteger timeout = [[NSString stringWithFormat:@"%lf",lefttime] integerValue];
//    NSInteger hour= timeout/3600;
//    NSInteger day = hour/24;
//    NSInteger hour2 = hour%24;
//    NSInteger min = (timeout-hour*3600)/60;
//    NSInteger sec = timeout%(60);
//    NSString *leftTime;
    
    
    secondsLabel.text = [NSString stringWithFormat:@"%.0f 秒", selectedDate.secondsUntil];
    minutesLabel.text = [NSString stringWithFormat:@"%.0f 分", selectedDate.minutesUntil];
    hoursLabel.text = [NSString stringWithFormat:@"%.0f 小时", selectedDate.hoursUntil];
    daysLabel.text = [NSString stringWithFormat:@"%ld 天", (long)selectedDate.daysUntil];
    monthLabel.text = [NSString stringWithFormat:@"%ld 月", (long)selectedDate.monthsUntil];
    
    NSInteger second = [[NSString stringWithFormat:@"%.0f", selectedDate.secondsUntil] integerValue];
    NSInteger seconds = second%60 ;//秒
    
    NSInteger min = [[NSString stringWithFormat:@"%.0f", selectedDate.minutesUntil]integerValue];
    NSInteger minutes = min%60 ;//分
    
    NSInteger hour = [[NSString stringWithFormat:@"%.0f", selectedDate.hoursUntil]integerValue];
    NSInteger hours = hour%24 ;//小时
    
    NSInteger day = [[NSString stringWithFormat:@"%ld", (long)selectedDate.daysUntil]integerValue];
    
    NSInteger days = day%30 ;//天
    
    
    countdownLabel.text = [NSString stringWithFormat:@"距今还有 %ld 月 %ld 天 %ld 小时 %ld 分 %ld 秒",selectedDate.monthsUntil,(long)days,(long)hours,(long)minutes,(long)seconds];
    
    
    
    
    
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
