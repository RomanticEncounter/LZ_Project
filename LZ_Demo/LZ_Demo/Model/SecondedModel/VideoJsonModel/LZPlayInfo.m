//
//  LZPlayInfo.m
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LZPlayInfo.h"


NSString *const kLZPlayInfoUrl = @"url";
NSString *const kLZPlayInfoHeight = @"height";
NSString *const kLZPlayInfoWidth = @"width";
NSString *const kLZPlayInfoName = @"name";
NSString *const kLZPlayInfoType = @"type";


@interface LZPlayInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LZPlayInfo

@synthesize url = _url;
@synthesize height = _height;
@synthesize width = _width;
@synthesize name = _name;
@synthesize type = _type;


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
            self.url = [self objectOrNilForKey:kLZPlayInfoUrl fromDictionary:dict];
            self.height = [[self objectOrNilForKey:kLZPlayInfoHeight fromDictionary:dict] doubleValue];
            self.width = [[self objectOrNilForKey:kLZPlayInfoWidth fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kLZPlayInfoName fromDictionary:dict];
            self.type = [self objectOrNilForKey:kLZPlayInfoType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.url forKey:kLZPlayInfoUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kLZPlayInfoHeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kLZPlayInfoWidth];
    [mutableDict setValue:self.name forKey:kLZPlayInfoName];
    [mutableDict setValue:self.type forKey:kLZPlayInfoType];

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

    self.url = [aDecoder decodeObjectForKey:kLZPlayInfoUrl];
    self.height = [aDecoder decodeDoubleForKey:kLZPlayInfoHeight];
    self.width = [aDecoder decodeDoubleForKey:kLZPlayInfoWidth];
    self.name = [aDecoder decodeObjectForKey:kLZPlayInfoName];
    self.type = [aDecoder decodeObjectForKey:kLZPlayInfoType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_url forKey:kLZPlayInfoUrl];
    [aCoder encodeDouble:_height forKey:kLZPlayInfoHeight];
    [aCoder encodeDouble:_width forKey:kLZPlayInfoWidth];
    [aCoder encodeObject:_name forKey:kLZPlayInfoName];
    [aCoder encodeObject:_type forKey:kLZPlayInfoType];
}

- (id)copyWithZone:(NSZone *)zone
{
    LZPlayInfo *copy = [[LZPlayInfo alloc] init];
    
    if (copy) {

        copy.url = [self.url copyWithZone:zone];
        copy.height = self.height;
        copy.width = self.width;
        copy.name = [self.name copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
    }
    
    return copy;
}


@end
