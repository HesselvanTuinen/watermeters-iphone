//
//  RestfulObject.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RestfulObject : NSObject {
	
}

+ (NSString *)cacheFilenameForURL:(NSString *)url;
+ (void)ensureCacheStoreExists;
+ (void)cacheContent:(NSString *)xml forURL:(NSString *)url;
+ (NSString *)getContentForURL:(NSString *)url;
+ (void)clearCache;
+ (void)removeAllWithPattern:(NSString *)p;

@end
