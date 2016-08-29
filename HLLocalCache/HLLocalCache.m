//
//  HLLocalCache.m
//
//  Created by tusm on 16/8/28.
//  Copyright © 2016年 hery.com. All rights reserved.
//

#import "HLLocalCache.h"

@implementation HLLocalCache

+(HLLocalCache*) sharedInstance {
    static HLLocalCache *singletonInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        singletonInstance = [[HLLocalCache alloc] init];
    });
    return singletonInstance;
}

#pragma mark - in Selected Directory
-(BOOL) cacheObject:(id)obj atPath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory {
    //check path
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachePath = [fileManager URLsForDirectory:directory
                                              inDomains:NSUserDomainMask].lastObject.path;
    path = [cachePath stringByAppendingPathComponent:path];
    NSLog(@"CachePath:%@", path);
    
    //检查父目录是否存在
    NSString *lastComp = [path lastPathComponent];
    NSString  *ppath = [path substringToIndex:path.length - lastComp.length];
    if(![fileManager fileExistsAtPath:ppath]) {
        [fileManager createDirectoryAtPath:ppath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [obj writeToFile:path atomically:YES];
}

-(id) decacheObjectType:(enum CacheType)type atPath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory {
    // cache path
    path = [[[NSFileManager defaultManager] URLsForDirectory:directory
                                                   inDomains:NSUserDomainMask].lastObject.path stringByAppendingPathComponent:path];
    switch (type) {
            break;
        case HLArray:
            return [NSArray arrayWithContentsOfFile:path];
        case HLDictionary:
            return [NSDictionary dictionaryWithContentsOfFile:path];
        case HLData:
            return [NSData dataWithContentsOfFile:path];
        default:
            break;
    }
    return nil;
}

#pragma mark - inCacheDirectory
-(BOOL) cacheObject:(id)obj atPath:(NSString *)path {
    return [self cacheObject:obj atPath:path inDirectory:NSCachesDirectory];
}

-(id) decacheObjectType:(enum CacheType) type atPath:(NSString*) path {
    return [self decacheObjectType:type atPath:path inDirectory:NSCachesDirectory];
}

@end


#pragma mark - NSCacheArray
@implementation NSArray (NSCacheArray)

-(BOOL) cacheArrayAtPath:(NSString *)path {
    return [[HLLocalCache sharedInstance] cacheObject:self atPath:path];
}
+(NSArray*) arrayWithCachePath:(NSString *)path {
    return [[HLLocalCache sharedInstance] decacheObjectType:HLArray atPath:path];
}

-(BOOL) cacheArrayAtPath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory {
    return [[HLLocalCache sharedInstance] cacheObject:self atPath:path inDirectory:directory];
}

+(NSArray*) arrayWithCachePath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory {
    return [[HLLocalCache sharedInstance] decacheObjectType:HLArray atPath:path inDirectory:directory];
}
@end

#pragma mark - NSCacheDirectory
@implementation NSDictionary (NSCacheDictionary)

-(BOOL) cacheDictionaryAtPath:(NSString *)path {
    return [[HLLocalCache sharedInstance] cacheObject:self atPath:path];
}
+(NSDictionary*) dictionaryWithCachePath:(NSString *)path {
    return [[HLLocalCache sharedInstance] decacheObjectType:HLDictionary atPath:path];
}

-(BOOL) cacheDictionaryAtPath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory {
    return [[HLLocalCache sharedInstance] cacheObject:self atPath:path inDirectory:directory];
}
+(NSDictionary*) dictionaryWithCachePath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory {
    return [[HLLocalCache sharedInstance] decacheObjectType:HLDictionary atPath:path inDirectory:directory];
}
@end

#pragma mark - NSCacheData
@implementation NSData (NSCacheData)

-(BOOL) cacheDataAtPath:(NSString *)path {
    return [[HLLocalCache sharedInstance] cacheObject:self atPath:path];
}
+(NSData*) dataWithCachePath:(NSString *)path {
    return [[HLLocalCache sharedInstance] decacheObjectType:HLData atPath:path];
}

-(BOOL) cacheDataAtPath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory {
    return [[HLLocalCache sharedInstance] cacheObject:self atPath:path inDirectory:directory];
}
+(NSData*) dataWithCachePath:(NSString *)path inDirectory:(NSSearchPathDirectory)directory {
    return [[HLLocalCache sharedInstance] decacheObjectType:HLData atPath:path inDirectory:directory];
}
@end
