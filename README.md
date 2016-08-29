# HLLocalCache
Read/Write NSArray,NSDictionary,NSData without path exist check.

# Usage
## Use `HLLocalCache` 
There are two functions to read/write NSArray,NSDictionary,NSData:
1、`-(BOOL) cacheObject:(id) obj atPath:(NSString*) path;` to cache object into specified path, if `path` isn't exist, it will be created.
2、`-(id) decacheObjectType:(enum CacheType) type atPath:(NSString*) path;` read from the specified path.

## Use Category
Take NSArray for example.
1、your can use `-(BOOL) cacheArrayAtPath:(NSString*) path;` to save this into specified path, if `path` isn't exist, it will be created.
1、use `+(NSArray*) arrayWithCachePath:(NSString*) path;` to read from the specified path.
