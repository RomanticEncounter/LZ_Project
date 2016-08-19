//
//  LZPlayerModel.m
//  LZ_Demo
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "LZPlayerModel.h"

@implementation LZPlayerModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // 转换系统关键字description
    if ([key isEqualToString:@"description"]) {
        self.detailedText = [NSString stringWithFormat:@"%@",value];
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"playInfo"]) {
        self.playInfo = @[].mutableCopy;
        NSMutableArray *array = @[].mutableCopy;
        for (NSDictionary *dataDic in value) {
            LZPlayerResolution *resolution = [[LZPlayerResolution alloc] init];
            [resolution setValuesForKeysWithDictionary:dataDic];
            [array addObject:resolution];
        }
        [self.playInfo removeAllObjects];
        [self.playInfo addObjectsFromArray:array];
    } else if ([key isEqualToString:@"title"]) {
        self.titleName = value;
    } else if ([key isEqualToString:@"playUrl"]) {
        self.playURL = value;
    } else if ([key isEqualToString:@"coverForFeed"]) {
        self.playerImg = value;
    }
    
}


@end
