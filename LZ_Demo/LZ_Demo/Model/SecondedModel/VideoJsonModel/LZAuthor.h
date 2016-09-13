//
//  LZAuthor.h
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LZAuthor : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double authorIdentifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *link;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
