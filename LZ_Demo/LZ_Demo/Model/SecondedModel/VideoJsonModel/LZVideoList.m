//
//  LZVideoList.m
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LZVideoList.h"
#import "LZPlayInfo.h"
#import "LZConsumption.h"
#import "LZProvider.h"


NSString *const kLZVideoListWebUrl = @"webUrl";
NSString *const kLZVideoListShareAdTrack = @"shareAdTrack";
NSString *const kLZVideoListCoverBlurred = @"coverBlurred";
NSString *const kLZVideoListTitle = @"title";
NSString *const kLZVideoListWebAdTrack = @"webAdTrack";
NSString *const kLZVideoListPlayInfo = @"playInfo";
NSString *const kLZVideoListDuration = @"duration";
NSString *const kLZVideoListIdx = @"idx";
NSString *const kLZVideoListFavoriteAdTrack = @"favoriteAdTrack";
NSString *const kLZVideoListRawWebUrl = @"rawWebUrl";
NSString *const kLZVideoListCoverForFeed = @"coverForFeed";
NSString *const kLZVideoListCategory = @"category";
NSString *const kLZVideoListConsumption = @"consumption";
NSString *const kLZVideoListWaterMarks = @"waterMarks";
NSString *const kLZVideoListId = @"id";
NSString *const kLZVideoListDate = @"date";
NSString *const kLZVideoListCoverForDetail = @"coverForDetail";
NSString *const kLZVideoListPlayUrl = @"playUrl";
NSString *const kLZVideoListPromotion = @"promotion";
NSString *const kLZVideoListCoverForSharing = @"coverForSharing";
NSString *const kLZVideoListProvider = @"provider";
NSString *const kLZVideoListAdTrack = @"adTrack";
NSString *const kLZVideoListAuthor = @"author";
NSString *const kLZVideoListDescription = @"description";


@interface LZVideoList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LZVideoList

@synthesize webUrl = _webUrl;
@synthesize shareAdTrack = _shareAdTrack;
@synthesize coverBlurred = _coverBlurred;
@synthesize title = _title;
@synthesize webAdTrack = _webAdTrack;
@synthesize playInfo = _playInfo;
@synthesize duration = _duration;
@synthesize idx = _idx;
@synthesize favoriteAdTrack = _favoriteAdTrack;
@synthesize rawWebUrl = _rawWebUrl;
@synthesize coverForFeed = _coverForFeed;
@synthesize category = _category;
@synthesize consumption = _consumption;
@synthesize waterMarks = _waterMarks;
@synthesize videoListIdentifier = _videoListIdentifier;
@synthesize date = _date;
@synthesize coverForDetail = _coverForDetail;
@synthesize playUrl = _playUrl;
@synthesize promotion = _promotion;
@synthesize coverForSharing = _coverForSharing;
@synthesize provider = _provider;
@synthesize adTrack = _adTrack;
@synthesize author = _author;
@synthesize videoListDescription = _videoListDescription;


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
            self.webUrl = [self objectOrNilForKey:kLZVideoListWebUrl fromDictionary:dict];
            self.shareAdTrack = [self objectOrNilForKey:kLZVideoListShareAdTrack fromDictionary:dict];
            self.coverBlurred = [self objectOrNilForKey:kLZVideoListCoverBlurred fromDictionary:dict];
            self.title = [self objectOrNilForKey:kLZVideoListTitle fromDictionary:dict];
            self.webAdTrack = [self objectOrNilForKey:kLZVideoListWebAdTrack fromDictionary:dict];
    NSObject *receivedLZPlayInfo = [dict objectForKey:kLZVideoListPlayInfo];
    NSMutableArray *parsedLZPlayInfo = [NSMutableArray array];
    if ([receivedLZPlayInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLZPlayInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLZPlayInfo addObject:[LZPlayInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLZPlayInfo isKindOfClass:[NSDictionary class]]) {
       [parsedLZPlayInfo addObject:[LZPlayInfo modelObjectWithDictionary:(NSDictionary *)receivedLZPlayInfo]];
    }

    self.playInfo = [NSArray arrayWithArray:parsedLZPlayInfo];
            self.duration = [[self objectOrNilForKey:kLZVideoListDuration fromDictionary:dict] doubleValue];
            self.idx = [[self objectOrNilForKey:kLZVideoListIdx fromDictionary:dict] doubleValue];
            self.favoriteAdTrack = [self objectOrNilForKey:kLZVideoListFavoriteAdTrack fromDictionary:dict];
            self.rawWebUrl = [self objectOrNilForKey:kLZVideoListRawWebUrl fromDictionary:dict];
            self.coverForFeed = [self objectOrNilForKey:kLZVideoListCoverForFeed fromDictionary:dict];
            self.category = [self objectOrNilForKey:kLZVideoListCategory fromDictionary:dict];
            self.consumption = [LZConsumption modelObjectWithDictionary:[dict objectForKey:kLZVideoListConsumption]];
            self.waterMarks = [self objectOrNilForKey:kLZVideoListWaterMarks fromDictionary:dict];
            self.videoListIdentifier = [[self objectOrNilForKey:kLZVideoListId fromDictionary:dict] doubleValue];
            self.date = [[self objectOrNilForKey:kLZVideoListDate fromDictionary:dict] doubleValue];
            self.coverForDetail = [self objectOrNilForKey:kLZVideoListCoverForDetail fromDictionary:dict];
            self.playUrl = [self objectOrNilForKey:kLZVideoListPlayUrl fromDictionary:dict];
            self.promotion = [self objectOrNilForKey:kLZVideoListPromotion fromDictionary:dict];
            self.coverForSharing = [self objectOrNilForKey:kLZVideoListCoverForSharing fromDictionary:dict];
            self.provider = [LZProvider modelObjectWithDictionary:[dict objectForKey:kLZVideoListProvider]];
            self.adTrack = [self objectOrNilForKey:kLZVideoListAdTrack fromDictionary:dict];
            self.author = [self objectOrNilForKey:kLZVideoListAuthor fromDictionary:dict];
            self.videoListDescription = [self objectOrNilForKey:kLZVideoListDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.webUrl forKey:kLZVideoListWebUrl];
    [mutableDict setValue:self.shareAdTrack forKey:kLZVideoListShareAdTrack];
    [mutableDict setValue:self.coverBlurred forKey:kLZVideoListCoverBlurred];
    [mutableDict setValue:self.title forKey:kLZVideoListTitle];
    [mutableDict setValue:self.webAdTrack forKey:kLZVideoListWebAdTrack];
    NSMutableArray *tempArrayForPlayInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.playInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPlayInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPlayInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPlayInfo] forKey:kLZVideoListPlayInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kLZVideoListDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.idx] forKey:kLZVideoListIdx];
    [mutableDict setValue:self.favoriteAdTrack forKey:kLZVideoListFavoriteAdTrack];
    [mutableDict setValue:self.rawWebUrl forKey:kLZVideoListRawWebUrl];
    [mutableDict setValue:self.coverForFeed forKey:kLZVideoListCoverForFeed];
    [mutableDict setValue:self.category forKey:kLZVideoListCategory];
    [mutableDict setValue:[self.consumption dictionaryRepresentation] forKey:kLZVideoListConsumption];
    [mutableDict setValue:self.waterMarks forKey:kLZVideoListWaterMarks];
    [mutableDict setValue:[NSNumber numberWithDouble:self.videoListIdentifier] forKey:kLZVideoListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.date] forKey:kLZVideoListDate];
    [mutableDict setValue:self.coverForDetail forKey:kLZVideoListCoverForDetail];
    [mutableDict setValue:self.playUrl forKey:kLZVideoListPlayUrl];
    [mutableDict setValue:self.promotion forKey:kLZVideoListPromotion];
    [mutableDict setValue:self.coverForSharing forKey:kLZVideoListCoverForSharing];
    [mutableDict setValue:[self.provider dictionaryRepresentation] forKey:kLZVideoListProvider];
    [mutableDict setValue:self.adTrack forKey:kLZVideoListAdTrack];
    [mutableDict setValue:self.author forKey:kLZVideoListAuthor];
    [mutableDict setValue:self.videoListDescription forKey:kLZVideoListDescription];

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

    self.webUrl = [aDecoder decodeObjectForKey:kLZVideoListWebUrl];
    self.shareAdTrack = [aDecoder decodeObjectForKey:kLZVideoListShareAdTrack];
    self.coverBlurred = [aDecoder decodeObjectForKey:kLZVideoListCoverBlurred];
    self.title = [aDecoder decodeObjectForKey:kLZVideoListTitle];
    self.webAdTrack = [aDecoder decodeObjectForKey:kLZVideoListWebAdTrack];
    self.playInfo = [aDecoder decodeObjectForKey:kLZVideoListPlayInfo];
    self.duration = [aDecoder decodeDoubleForKey:kLZVideoListDuration];
    self.idx = [aDecoder decodeDoubleForKey:kLZVideoListIdx];
    self.favoriteAdTrack = [aDecoder decodeObjectForKey:kLZVideoListFavoriteAdTrack];
    self.rawWebUrl = [aDecoder decodeObjectForKey:kLZVideoListRawWebUrl];
    self.coverForFeed = [aDecoder decodeObjectForKey:kLZVideoListCoverForFeed];
    self.category = [aDecoder decodeObjectForKey:kLZVideoListCategory];
    self.consumption = [aDecoder decodeObjectForKey:kLZVideoListConsumption];
    self.waterMarks = [aDecoder decodeObjectForKey:kLZVideoListWaterMarks];
    self.videoListIdentifier = [aDecoder decodeDoubleForKey:kLZVideoListId];
    self.date = [aDecoder decodeDoubleForKey:kLZVideoListDate];
    self.coverForDetail = [aDecoder decodeObjectForKey:kLZVideoListCoverForDetail];
    self.playUrl = [aDecoder decodeObjectForKey:kLZVideoListPlayUrl];
    self.promotion = [aDecoder decodeObjectForKey:kLZVideoListPromotion];
    self.coverForSharing = [aDecoder decodeObjectForKey:kLZVideoListCoverForSharing];
    self.provider = [aDecoder decodeObjectForKey:kLZVideoListProvider];
    self.adTrack = [aDecoder decodeObjectForKey:kLZVideoListAdTrack];
    self.author = [aDecoder decodeObjectForKey:kLZVideoListAuthor];
    self.videoListDescription = [aDecoder decodeObjectForKey:kLZVideoListDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_webUrl forKey:kLZVideoListWebUrl];
    [aCoder encodeObject:_shareAdTrack forKey:kLZVideoListShareAdTrack];
    [aCoder encodeObject:_coverBlurred forKey:kLZVideoListCoverBlurred];
    [aCoder encodeObject:_title forKey:kLZVideoListTitle];
    [aCoder encodeObject:_webAdTrack forKey:kLZVideoListWebAdTrack];
    [aCoder encodeObject:_playInfo forKey:kLZVideoListPlayInfo];
    [aCoder encodeDouble:_duration forKey:kLZVideoListDuration];
    [aCoder encodeDouble:_idx forKey:kLZVideoListIdx];
    [aCoder encodeObject:_favoriteAdTrack forKey:kLZVideoListFavoriteAdTrack];
    [aCoder encodeObject:_rawWebUrl forKey:kLZVideoListRawWebUrl];
    [aCoder encodeObject:_coverForFeed forKey:kLZVideoListCoverForFeed];
    [aCoder encodeObject:_category forKey:kLZVideoListCategory];
    [aCoder encodeObject:_consumption forKey:kLZVideoListConsumption];
    [aCoder encodeObject:_waterMarks forKey:kLZVideoListWaterMarks];
    [aCoder encodeDouble:_videoListIdentifier forKey:kLZVideoListId];
    [aCoder encodeDouble:_date forKey:kLZVideoListDate];
    [aCoder encodeObject:_coverForDetail forKey:kLZVideoListCoverForDetail];
    [aCoder encodeObject:_playUrl forKey:kLZVideoListPlayUrl];
    [aCoder encodeObject:_promotion forKey:kLZVideoListPromotion];
    [aCoder encodeObject:_coverForSharing forKey:kLZVideoListCoverForSharing];
    [aCoder encodeObject:_provider forKey:kLZVideoListProvider];
    [aCoder encodeObject:_adTrack forKey:kLZVideoListAdTrack];
    [aCoder encodeObject:_author forKey:kLZVideoListAuthor];
    [aCoder encodeObject:_videoListDescription forKey:kLZVideoListDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    LZVideoList *copy = [[LZVideoList alloc] init];
    
    if (copy) {

        copy.webUrl = [self.webUrl copyWithZone:zone];
        copy.shareAdTrack = [self.shareAdTrack copyWithZone:zone];
        copy.coverBlurred = [self.coverBlurred copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.webAdTrack = [self.webAdTrack copyWithZone:zone];
        copy.playInfo = [self.playInfo copyWithZone:zone];
        copy.duration = self.duration;
        copy.idx = self.idx;
        copy.favoriteAdTrack = [self.favoriteAdTrack copyWithZone:zone];
        copy.rawWebUrl = [self.rawWebUrl copyWithZone:zone];
        copy.coverForFeed = [self.coverForFeed copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
        copy.consumption = [self.consumption copyWithZone:zone];
        copy.waterMarks = [self.waterMarks copyWithZone:zone];
        copy.videoListIdentifier = self.videoListIdentifier;
        copy.date = self.date;
        copy.coverForDetail = [self.coverForDetail copyWithZone:zone];
        copy.playUrl = [self.playUrl copyWithZone:zone];
        copy.promotion = [self.promotion copyWithZone:zone];
        copy.coverForSharing = [self.coverForSharing copyWithZone:zone];
        copy.provider = [self.provider copyWithZone:zone];
        copy.adTrack = [self.adTrack copyWithZone:zone];
        copy.author = [self.author copyWithZone:zone];
        copy.videoListDescription = [self.videoListDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
