//
//  AbstractRequest.m
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AbstractRequest.h"
#import "RestfulObject.h"
#import "WebService.h"
#import "XmlParser.h"

@implementation AbstractRequest

@synthesize urlString;

- (id)init {
	if (self = [super init]) {
		self.urlString = [NSMutableString stringWithCapacity:50];
	}
	return self;
}

- (NSArray *)doRequest {
	return [self doRequestUsingCache:YES requestMethod:@"GET"];
}

- (NSArray *)doRequestUsingCache:(BOOL)useCache requestMethod:(NSString *)requestMethod {
	[self generateUrlString];

	NSString *xml = nil;
	NSArray *results = [NSArray array];

	// Get XML from cache
	if (useCache) { 
		xml = [RestfulObject getContentForURL:self.urlString];
	}
	
	// Use webservice
	if (!xml) {
		NSData *data = [[WebService sendSyncRequest:self.urlString Method:requestMethod] retain];
		if (data && [data length] > 0) {
			xml = [NSString stringWithCString:[data bytes] length:[data length]];
			NSLog(@"xml:\n%@", xml);
			[RestfulObject cacheContent:xml forURL:self.urlString]; // Cache it
		} else {
			NSLog(@"Failed to request");
		}
	}
	
	if (xml) {
		NSDictionary *dictionary = [XmlParser parseXml:xml];
		results = [self parseDictionary:dictionary];
	}
	
	return results;
}

- (void) dealloc {
	[urlString release];
	
	[super dealloc];
}

- (void)generateUrlString {
}

- (NSArray *)parseDictionary:(NSDictionary *)dictionary {
	return [NSArray array];
}

@end
