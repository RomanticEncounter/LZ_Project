//
//  LZBaseClass.h
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LZBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *videoList;
@property (nonatomic, assign) id nextPageUrl;
@property (nonatomic, assign) double count;
@property (nonatomic, assign) double total;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
