//
//  LZConsumption.m
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LZConsumption.h"


NSString *const kLZConsumptionShareCount = @"shareCount";
NSString *const kLZConsumptionCollectionCount = @"collectionCount";
NSString *const kLZConsumptionReplyCount = @"replyCount";
NSString *const kLZConsumptionPlayCount = @"playCount";


@interface LZConsumption ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LZConsumption

@synthesize shareCount = _shareCount;
@synthesize collectionCount = _collectionCount;
@synthesize replyCount = _replyCount;
@synthesize playCount = _playCount;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.shareCount = [[self objectOrNilForKey:kLZConsumptionShareCount fromDictionary:dict] doubleValue];
            self.collectionCount = [[self objectOrNilForKey:kLZConsumptionCollectionCount fromDictionary:dict] doubleValue];
            self.replyCount = [[self objectOrNilForKey:kLZConsumptionReplyCount fromDictionary:dict] doubleValue];
            self.playCount = [[self objectOrNilForKey:kLZConsumptionPlayCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shareCount] forKey:kLZConsumptionShareCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.collectionCount] forKey:kLZConsumptionCollectionCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.replyCount] forKey:kLZConsumptionReplyCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.playCount] forKey:kLZConsumptionPlayCount];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.shareCount = [aDecoder decodeDoubleForKey:kLZConsumptionShareCount];
    self.collectionCount = [aDecoder decodeDoubleForKey:kLZConsumptionCollectionCount];
    self.replyCount = [aDecoder decodeDoubleForKey:kLZConsumptionReplyCount];
    self.playCount = [aDecoder decodeDoubleForKey:kLZConsumptionPlayCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_shareCount forKey:kLZConsumptionShareCount];
    [aCoder encodeDouble:_collectionCount forKey:kLZConsumptionCollectionCount];
    [aCoder encodeDouble:_replyCount forKey:kLZConsumptionReplyCount];
    [aCoder encodeDouble:_playCount forKey:kLZConsumptionPlayCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    LZConsumption *copy = [[LZConsumption alloc] init];
    
    if (copy) {

        copy.shareCount = self.shareCount;
        copy.collectionCount = self.collectionCount;
        copy.replyCount = self.replyCount;
        copy.playCount = self.playCount;
    }
    
    return copy;
}


@end
