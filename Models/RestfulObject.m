//
//  RestfulObject.m
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RestfulObject.h"


@implementation RestfulObject

#pragma mark -
#pragma mark Class methods

+ (NSString *)cacheFilenameForURL:(NSString *)url {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"URLCache"];
	NSString *safeUrl = [url stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
	return [cachePath stringByAppendingPathComponent:safeUrl];
}

// Create directory where chache files are stored
+ (void)ensureCacheStoreExists {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"URLCache"];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) 
	{
		[[NSFileManager defaultManager] createDirectoryAtPath:cachePath 
		                          withIntermediateDirectories:NO
		                                           attributes:nil 
		                                                error:nil];
	}
}

// Write XML content to cache file
+ (void)cacheContent:(NSString *)xml forURL:(NSString *)url {
	[xml writeToFile:[RestfulObject cacheFilenameForURL:url] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

// Get XML for cache file
+ (NSString *)getContentForURL:(NSString *)url {
	NSString *filename = [RestfulObject cacheFilenameForURL:url];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filename]) {
		return [[NSString alloc] initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:nil];
	}
	
	return nil;
}

+ (void)clearCache {
	[RestfulObject removeAllWithPattern:@""];
}

+ (void)removeAllWithPattern:(NSString *)p {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"URLCache"];
	NSArray *directoryContents = [[NSFileManager defaultManager] directoryContentsAtPath:cachePath];
	for (NSString *filename in directoryContents) {
		NSString *filepath = [cachePath stringByAppendingPathComponent:filename];
		
		if ([p isEqualToString:@""] || [filepath rangeOfString:p].location != NSNotFound) {
			NSLog(@"removing %@", filepath);
			[[NSFileManager defaultManager] removeItemAtPath:filepath error:NULL];
		} else {
			NSLog(@"keeping %@", filepath);
		}
	}
}

@end
