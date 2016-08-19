//
//  LZVideoTableViewCell.h
//  LZ_Demo
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFPlayer.h"
#import "LZPlayerModel.h"
typedef void(^PlayBtnCallBackBlock)(UIButton *);

@interface LZVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *detailText;
@property (weak, nonatomic) IBOutlet UIImageView *picVedioView;

@property (nonatomic, strong) UIButton *playButton ;
@property (nonatomic, strong) LZPlayerModel *model ;
@property (nonatomic, copy) PlayBtnCallBackBlock playBlock;

@end
