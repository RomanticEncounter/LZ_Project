//
//  FirstTableViewCell.m
//  LZ_Demo
//
//  Created by mac on 16/8/5.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommonSingleton.h"
@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userHeadImg.layer.cornerRadius = 25 ;
    self.userHeadImg.layer.masksToBounds = YES ;
    
    /**
     *  根据宽高比,自适应图片大小
     */
    self.picture.contentMode = UIViewContentModeScaleAspectFit;
    self.picture.autoresizesSubviews = YES;
    self.picture.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    

    
}
- (void)setModel:(FirstModel *)model
{
    _model = model ;
    [self.userHeadImg sd_setImageWithURL:[NSURL URLWithString:model.userHeadImg] placeholderImage:nil];
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.backGroundImg] placeholderImage:nil];
    self.timeLabel.text = model.time ;
    self.userName.text = model.userName ;
    self.titleLabel.text = model.title ;
    self.detailLabel.text = model.detailText ;
    
}
- (void)cellAutoLayoutHeight:(NSString *)str
{
    self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping ;
    self.detailLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.detailLabel.frame);
    self.detailLabel.text = str ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
