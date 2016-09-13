//
//  SecondViewController.m
//  LZ_Demo
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "SecondViewController.h"
#import "CommonSingleton.h"
#import "DataModels.h"
#import "LZVideoTableViewCell.h"
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView ;
@property (nonatomic, strong) NSMutableArray *dataSourceArray ;
@property (nonatomic, strong) LZBaseClass *baseClass ;
@property (nonatomic, strong) ZFPlayerView   *playerView;
@end

@implementation SecondViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"第二页";
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 100, 100, 100);
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(hudClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    self.dataSourceArray = @[].mutableCopy;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self ;
    self.tableView.delegate = self ;
    self.tableView.estimatedRowHeight = 300 ;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"LZVideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"playerCell"];
//    NSArray *videoList = [rootDict objectForKey:@"videoList"];
//    _baseClass.videoList = videoList;
    self.baseClass = [[LZBaseClass alloc]initWithDictionary:rootDict];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseClass.videoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier        = @"playerCell";
    LZVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.videoModel = self.baseClass.videoList[indexPath.row];
    
    
    __block NSIndexPath *weakIndexPath = indexPath;
    __block LZVideoTableViewCell *weakCell     = cell;
    __weak typeof(self) weakSelf       = self;

    cell.playBlock = ^(UIButton *btn){
        weakSelf.playerView = [ZFPlayerView sharedPlayerView];
        // 分辨率字典（key:分辨率名称，value：分辨率url)
        NSMutableDictionary *dic = @{}.mutableCopy;
        for (LZPlayInfo * resolution in weakCell.videoModel.playInfo) {
            [dic setValue:resolution.url forKey:resolution.name];
        }
        // 取出字典中的第一视频URL
        NSURL *videoURL = [NSURL URLWithString:dic.allValues.firstObject];
        
        // 设置player相关参数(需要设置imageView的tag值，此处设置的为101)
        [weakSelf.playerView setVideoURL:videoURL
                           withTableView:weakSelf.tableView
                             AtIndexPath:weakIndexPath
                        withImageViewTag:101];
        [weakSelf.playerView addPlayerToCellImageView:weakCell.picVedioView];
        // 赋值分辨率字典
//        weakSelf.playerView.resolutionDic = dic;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        weakSelf.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    };
    
    return cell;
}





//- (void)hudClick:(UIButton *)button
//{
////    [CommonSingleton MBTextHUDAddView:self.navigationController.view Text:@""];
//    [CommonSingleton MBLoadingHUDAddView:self.view];
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//        sleep(3);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [CommonSingleton MBHUDdismiss];
//        });
//    });
//
//}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view.backgroundColor = [UIColor blackColor];
    }
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
