//
//  LZVideoTableViewCell.m
//  LZ_Demo
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "LZVideoTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation LZVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self cutRoundView:self.headerIcon];
    self.picVedioView.tag = 101;
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playButton setImage:[UIImage imageNamed:ZFPlayerSrcName(@"ZFPlayer_play_btn")] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.picVedioView addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.picVedioView);
    }];
    
}
/**
 *  切圆角
 */
- (void)cutRoundView:(UIImageView *)imageView
{
    CGFloat corner = imageView.frame.size.width / 2;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
    shapeLayer.path = path.CGPath;
    imageView.layer.mask = shapeLayer;
}
//- (void)setModel:(LZVideoList *)model
//{
//    [self.picVedioView sd_setImageWithURL:[NSURL URLWithString:model.playerImg] placeholderImage:[UIImage imageNamed:@"loading_bgView"]];
//    [self.headerIcon sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:nil];
//    self.titleName.text = model.titleName;
//    self.detailText.text = model.detailedText ;
//}
- (void)setVideoModel:(LZVideoList *)videoModel
{
    _videoModel = videoModel ;
    [self.picVedioView sd_setImageWithURL:[NSURL URLWithString:videoModel.coverForFeed] placeholderImage:[UIImage imageNamed:@"loading_bgView"]];
    [self.headerIcon sd_setImageWithURL:[NSURL URLWithString:videoModel.provider.icon] placeholderImage:nil];
    self.titleName.text = videoModel.title;
    self.detailText.text = videoModel.videoListDescription ;
    self.categoryLabel.text = videoModel.category ;
}


- (void)play:(UIButton *)sender {
    if (self.playBlock) {
        self.playBlock(sender);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
