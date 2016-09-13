//
//  LZProvider.m
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LZProvider.h"


NSString *const kLZProviderName = @"name";
NSString *const kLZProviderAlias = @"alias";
NSString *const kLZProviderIcon = @"icon";


@interface LZProvider ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LZProvider

@synthesize name = _name;
@synthesize alias = _alias;
@synthesize icon = _icon;


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
            self.name = [self objectOrNilForKey:kLZProviderName fromDictionary:dict];
            self.alias = [self objectOrNilForKey:kLZProviderAlias fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kLZProviderIcon fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kLZProviderName];
    [mutableDict setValue:self.alias forKey:kLZProviderAlias];
    [mutableDict setValue:self.icon forKey:kLZProviderIcon];

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

    self.name = [aDecoder decodeObjectForKey:kLZProviderName];
    self.alias = [aDecoder decodeObjectForKey:kLZProviderAlias];
    self.icon = [aDecoder decodeObjectForKey:kLZProviderIcon];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kLZProviderName];
    [aCoder encodeObject:_alias forKey:kLZProviderAlias];
    [aCoder encodeObject:_icon forKey:kLZProviderIcon];
}

- (id)copyWithZone:(NSZone *)zone
{
    LZProvider *copy = [[LZProvider alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.alias = [self.alias copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
    }
    
    return copy;
}


@end
