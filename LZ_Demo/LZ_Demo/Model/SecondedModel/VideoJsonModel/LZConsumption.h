//
//  LZConsumption.h
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LZConsumption : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double shareCount;
@property (nonatomic, assign) double collectionCount;
@property (nonatomic, assign) double replyCount;
@property (nonatomic, assign) double playCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
