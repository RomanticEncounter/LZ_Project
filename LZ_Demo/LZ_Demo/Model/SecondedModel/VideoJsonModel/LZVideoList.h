//
//  LZVideoList.h
//
//  Created by   on 16/9/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LZConsumption, LZProvider;

@interface LZVideoList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, assign) id shareAdTrack;
@property (nonatomic, strong) NSString *coverBlurred;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) id webAdTrack;
@property (nonatomic, strong) NSArray *playInfo;
@property (nonatomic, assign) double duration;
@property (nonatomic, assign) double idx;
@property (nonatomic, assign) id favoriteAdTrack;
@property (nonatomic, strong) NSString *rawWebUrl;
@property (nonatomic, strong) NSString *coverForFeed;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) LZConsumption *consumption;
@property (nonatomic, assign) id waterMarks;
@property (nonatomic, assign) double videoListIdentifier;
@property (nonatomic, assign) double date;
@property (nonatomic, strong) NSString *coverForDetail;
@property (nonatomic, strong) NSString *playUrl;
@property (nonatomic, assign) id promotion;
@property (nonatomic, strong) NSString *coverForSharing;
@property (nonatomic, strong) LZProvider *provider;
@property (nonatomic, assign) id adTrack;
@property (nonatomic, assign) id author;
@property (nonatomic, strong) NSString *videoListDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
