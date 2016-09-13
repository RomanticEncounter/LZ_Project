//
//  LZBaseClass.m
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LZBaseClass.h"
#import "LZVideoList.h"


NSString *const kLZBaseClassVideoList = @"videoList";
NSString *const kLZBaseClassNextPageUrl = @"nextPageUrl";
NSString *const kLZBaseClassCount = @"count";
NSString *const kLZBaseClassTotal = @"total";


@interface LZBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LZBaseClass

@synthesize videoList = _videoList;
@synthesize nextPageUrl = _nextPageUrl;
@synthesize count = _count;
@synthesize total = _total;


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
    NSObject *receivedLZVideoList = [dict objectForKey:kLZBaseClassVideoList];
    NSMutableArray *parsedLZVideoList = [NSMutableArray array];
    if ([receivedLZVideoList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLZVideoList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLZVideoList addObject:[LZVideoList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLZVideoList isKindOfClass:[NSDictionary class]]) {
       [parsedLZVideoList addObject:[LZVideoList modelObjectWithDictionary:(NSDictionary *)receivedLZVideoList]];
    }

    self.videoList = [NSArray arrayWithArray:parsedLZVideoList];
            self.nextPageUrl = [self objectOrNilForKey:kLZBaseClassNextPageUrl fromDictionary:dict];
            self.count = [[self objectOrNilForKey:kLZBaseClassCount fromDictionary:dict] doubleValue];
            self.total = [[self objectOrNilForKey:kLZBaseClassTotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForVideoList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.videoList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVideoList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVideoList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVideoList] forKey:kLZBaseClassVideoList];
    [mutableDict setValue:self.nextPageUrl forKey:kLZBaseClassNextPageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kLZBaseClassCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kLZBaseClassTotal];

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

    self.videoList = [aDecoder decodeObjectForKey:kLZBaseClassVideoList];
    self.nextPageUrl = [aDecoder decodeObjectForKey:kLZBaseClassNextPageUrl];
    self.count = [aDecoder decodeDoubleForKey:kLZBaseClassCount];
    self.total = [aDecoder decodeDoubleForKey:kLZBaseClassTotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_videoList forKey:kLZBaseClassVideoList];
    [aCoder encodeObject:_nextPageUrl forKey:kLZBaseClassNextPageUrl];
    [aCoder encodeDouble:_count forKey:kLZBaseClassCount];
    [aCoder encodeDouble:_total forKey:kLZBaseClassTotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    LZBaseClass *copy = [[LZBaseClass alloc] init];
    
    if (copy) {

        copy.videoList = [self.videoList copyWithZone:zone];
        copy.nextPageUrl = [self.nextPageUrl copyWithZone:zone];
        copy.count = self.count;
        copy.total = self.total;
    }
    
    return copy;
}


@end
