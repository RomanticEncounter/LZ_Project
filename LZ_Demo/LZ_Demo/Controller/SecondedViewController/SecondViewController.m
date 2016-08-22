//
//  SecondViewController.m
//  LZ_Demo
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "SecondViewController.h"
#import "CommonSingleton.h"
#import "LZVideoTableViewCell.h"
#import "LZPlayerResolution.h"
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myAlarmClockTableView ;
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ZFPlayerView   *playerView;
@end

@implementation SecondViewController
// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}

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
    
    [myAlarmClockTableView registerNib:[UINib nibWithNibName:@"LZVideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    myAlarmClockTableView.estimatedRowHeight = 250.0f;
    myAlarmClockTableView.rowHeight = UITableViewAutomaticDimension;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    self.dataSource = @[].mutableCopy;
    NSArray *videoList = [rootDict objectForKey:@"videoList"];
    for (NSDictionary *dataDic in videoList) {
        LZPlayerModel *model = [[LZPlayerModel alloc] init];
        [model setValuesForKeysWithDictionary:dataDic];
        [self.dataSource addObject:model];
    }
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // 取到对应cell的model
    __block LZPlayerModel *model       = self.dataSource[indexPath.row];
    // 赋值model
    cell.model                         = model;
    
    __block NSIndexPath *weakIndexPath = indexPath;
    __block LZVideoTableViewCell *weakCell     = cell;
    __weak typeof(self) weakSelf       = self;
    // 点击播放的回调
    cell.playBlock = ^(UIButton *btn){
        weakSelf.playerView = [ZFPlayerView sharedPlayerView];
        // 分辨率字典（key:分辨率名称，value：分辨率url)
        NSMutableDictionary *dic = @{}.mutableCopy;
        for (LZPlayerResolution * resolution in model.playInfo) {
            [dic setValue:resolution.url forKey:resolution.name];
        }
        // 取出字典中的第一视频URL
        NSURL *videoURL = [NSURL URLWithString:dic.allValues.firstObject];
        
        // 设置player相关参数(需要设置imageView的tag值，此处设置的为101)
        [weakSelf.playerView setVideoURL:videoURL
                           withTableView:myAlarmClockTableView
                             AtIndexPath:weakIndexPath
                        withImageViewTag:101];
        [weakSelf.playerView addPlayerToCellImageView:weakCell.picVedioView];
        [weakSelf.playerView setVideoURL:videoURL withTableView:myAlarmClockTableView AtIndexPath:weakIndexPath withImageViewTag:101];
        
        // 下载功能
        weakSelf.playerView.hasDownload   = YES;
        // 赋值分辨率字典
        weakSelf.playerView.resolutionDic = dic;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        weakSelf.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        
    };

    return cell ;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view.backgroundColor = [UIColor blackColor];
    }
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
