//
//  LZPlayerResolution.h
//  LZ_Demo
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZPlayerResolution : NSObject
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, copy  ) NSString  *name;
@property (nonatomic, copy  ) NSString  *type;
@property (nonatomic, copy  ) NSString  *url;
@end
