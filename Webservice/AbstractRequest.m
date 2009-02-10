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

@interface AbstractRequest (Protected)
- (void)parse:(NSData*)data;
@end

@implementation AbstractRequest

@synthesize urlString, requestParser, results, done;

- (id)init {
	if (self = [super init]) {
		self.urlString = [NSMutableString stringWithCapacity:50];
		self.results = [NSMutableArray arrayWithCapacity:10];
		self.requestParser = [[NSXMLParser alloc] init];
		elements_stack = [[Stack alloc] init];
	}
	return self;
}

- (NSArray *)doRequest {
	return [self doRequestusingCache:YES];
}

- (NSArray *)doRequestusingCache:(BOOL)useCache {
	[self generateUrlString];

	NSString *xml;

	// Get XML from cache
	if (useCache) { 
		xml = [RestfulObject getContentForURL:self.urlString];
	}
	
	// Use webservice
	if (!xml) {
		NSData *data = [[WebService sendSyncRequest:self.urlString] retain];
		if (data && [data length] > 0) {
			xml = [NSString stringWithCString:[data bytes] length:[data length]];
			[RestfulObject cacheContent:xml forURL:self.urlString]; // Cache it
		} else {
			NSLog(@"Failed to request");
			done = YES;
		}
	}
	
	return [self parseXml:xml];
}

- (NSArray *)parseXml:(NSString *)xml {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[results removeAllObjects];
	done = NO;
	const char *axml = [xml UTF8String];
	[self parse:[NSData	dataWithBytes:axml length:strlen(axml)]];
	NSRunLoop *loop = [NSRunLoop currentRunLoop];
	while (!done) {
		NSLog(@"Waiting for end parse");
		[loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
	}
	
	[pool release];
	
	return results;
}

- (void)parse:(NSData *)data {
	[requestParser initWithData:data];
	[requestParser setDelegate:self];
	[requestParser setShouldResolveExternalEntities:NO];
	[requestParser setShouldProcessNamespaces:NO];
	[requestParser setShouldReportNamespacePrefixes:NO];
	[requestParser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	//NSLog(@"found file and started parsing");
}

- (void)parser:(NSXMLParser *)parse parseErrorOccurred:(NSError *)parseError {
	NSLog(@"error parsing XML: %d", [parseError code]);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:@"Error parsing XML" delegate:self 
												cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
	done = YES;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	[elements_stack push:elementName];
	[self initCurrent:attributeDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
{
	[elements_stack pop];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {    
	// NSLog(@"all done!");
	done = YES;
}

- (void) dealloc
{
	[urlString release];
	[results release];
	if (requestParser) [requestParser release];
	
	[elements_stack release];
	
	[super dealloc];
}

- (void)generateUrlString {
}

- (void)initCurrent:(NSDictionary *)attributeDict {
	[self initCurrent];
}

- (void)initCurrent {
}

// XML element that is currently parsed
- (NSString *)currentXmlElement {
	return [elements_stack top] ? (NSString *)[elements_stack top] : @"";
}

// XML element that encloses currentXmlElement
- (NSString *)enclosingXmlElement {
	return [elements_stack belowTop] ? (NSString *)[elements_stack belowTop] : @"";
}

@end
