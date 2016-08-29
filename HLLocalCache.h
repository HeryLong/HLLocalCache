//
//  HLLocalCache.h
//
//  Created by tusm on 16/8/28.
//  Copyright © 2016年 hery.com. All rights reserved.
//

#import <Foundation/Foundation.h>

enum CacheType {
    HLArray,
    HLDictionary,
    HLData,
};

// the main class to cache file into specified path or directory.
@interface HLLocalCache : NSObject

+(HLLocalCache*) sharedInstance;

// cache file into specified directory-path
-(BOOL) cacheObject:(id) obj atPath:(NSString*) path inDirectory:(NSSearchPathDirectory) directory;
-(id) decacheObjectType:(enum CacheType) type atPath:(NSString*) path inDirectory:(NSSearchPathDirectory) directory;

// cache file into NSCachePathDirectory
-(BOOL) cacheObject:(id) obj atPath:(NSString*) path;
-(id) decacheObjectType:(enum CacheType) type atPath:(NSString*) path;

@end

#pragma mark - NSArray Cache Category
@interface NSArray (NSCacheArray)

-(BOOL) cacheArrayAtPath:(NSString*) path inDirectory:(NSSearchPathDirectory) directory;
+(NSArray*) arrayWithCachePath:(NSString*) path inDirectory:(NSSearchPathDirectory) directory;
-(BOOL) cacheArrayAtPath:(NSString*) path;
+(NSArray*) arrayWithCachePath:(NSString*) path;

@end

#pragma mark - NSDictionary Cache Category
@interface NSDictionary (NSCacheDictionary)

-(BOOL) cacheDictionaryAtPath:(NSString*) path inDirectory:(NSSearchPathDirectory) directory;
+(NSDictionary*) dictionaryWithCachePath:(NSString*) path inDirectory:(NSSearchPathDirectory) directory;
-(BOOL) cacheDictionaryAtPath:(NSString*) path;
+(NSDictionary*) dictionaryWithCachePath:(NSString*) path;

@end

#pragma mark - NSData Cache Category
@interface NSData (NSCacheData)

-(BOOL) cacheDataAtPath:(NSString*) path inDirectory:(NSSearchPathDirectory) directory;
+(NSData*) dataWithCachePath:(NSString*) path inDirectory:(NSSearchPathDirectory) directory;
-(BOOL) cacheDataAtPath:(NSString*) path;
+(NSData*) dataWithCachePath:(NSString*) path;

@end
