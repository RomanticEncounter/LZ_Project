//
//  LZPlayerModel.h
//  LZ_Demo
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZPlayerResolution.h"
@interface LZPlayerModel : NSObject
/**
 *  标题
 */
@property (nonatomic, copy) NSString *titleName ;
/**
 *  详情
 */
@property (nonatomic, copy) NSString *detailedText ;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *headImg ;
/**
 *  URL
 */
@property (nonatomic, copy) NSString *playURL ;
/**
 *  封面图
 */
@property (nonatomic, copy) NSString *playerImg ;
/**
 *  分辨率数组
 */
@property (nonatomic, strong) NSMutableArray *playInfo;
@end
