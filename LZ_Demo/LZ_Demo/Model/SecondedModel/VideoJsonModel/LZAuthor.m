//
//  LZAuthor.m
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LZAuthor.h"


NSString *const kLZAuthorId = @"id";
NSString *const kLZAuthorName = @"name";
NSString *const kLZAuthorLink = @"link";


@interface LZAuthor ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LZAuthor

@synthesize authorIdentifier = _authorIdentifier;
@synthesize name = _name;
@synthesize link = _link;


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
            self.authorIdentifier = [[self objectOrNilForKey:kLZAuthorId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kLZAuthorName fromDictionary:dict];
            self.link = [self objectOrNilForKey:kLZAuthorLink fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.authorIdentifier] forKey:kLZAuthorId];
    [mutableDict setValue:self.name forKey:kLZAuthorName];
    [mutableDict setValue:self.link forKey:kLZAuthorLink];

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

    self.authorIdentifier = [aDecoder decodeDoubleForKey:kLZAuthorId];
    self.name = [aDecoder decodeObjectForKey:kLZAuthorName];
    self.link = [aDecoder decodeObjectForKey:kLZAuthorLink];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_authorIdentifier forKey:kLZAuthorId];
    [aCoder encodeObject:_name forKey:kLZAuthorName];
    [aCoder encodeObject:_link forKey:kLZAuthorLink];
}

- (id)copyWithZone:(NSZone *)zone
{
    LZAuthor *copy = [[LZAuthor alloc] init];
    
    if (copy) {

        copy.authorIdentifier = self.authorIdentifier;
        copy.name = [self.name copyWithZone:zone];
        copy.link = [self.link copyWithZone:zone];
    }
    
    return copy;
}


@end
