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
	return [self doRequestUsingCache:YES];
}

- (NSArray *)doRequestUsingCache:(BOOL)useCache {
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
	xmlDict = [[NSMutableDictionary alloc] init];
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
	// Set the type of current xml element (if it's not set already)
	XmlElement *currentXE = [self currentXmlElement];
	if (currentXE && currentXE.type == XmlElementTypeUnkown) {
		currentXE.type = XmlElementTypeDictionary;
		currentXE.valueObject = [[NSMutableDictionary alloc] init];
		[self updateDictionary];
	}
	
	XmlElement *xe = [XmlElement elementWithName:elementName];
	[elements_stack push:xe];

	// Check if current element has the attribute: type="array"
	NSString *value = [attributeDict objectForKey:@"type"];
	if (value && [value isEqualToString:@"array"]) {
		xe.type = XmlElementTypeArray;
		xe.valueObject = [[NSMutableArray alloc] init];
		[self updateDictionary];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	if ([string length] > 0) {
		// Set the type of current xml element and its value (if it's not set already)
		XmlElement *currentXE = [self currentXmlElement];
		if (currentXE && currentXE.type == XmlElementTypeUnkown) {
			currentXE.type = XmlElementTypeItem;
			currentXE.valueObject = [[NSMutableString alloc] init];
			[self updateDictionary];
		}
		
		[(NSMutableString *)currentXE.valueObject appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
{
	XmlElement *xmlElement = [elements_stack pop];
	NSLog(@"poped element with name = %@, type = %d", xmlElement.name, xmlElement.type);
	if (xmlElement.type == XmlElementTypeItem) NSLog(@" - with value: %@", xmlElement.valueObject);
	else if (xmlElement.type == XmlElementTypeArray) NSLog(@" - with count: %d", [(NSMutableArray *)xmlElement.valueObject count]);
	else {
		NSDictionary *dict = (NSMutableDictionary *)xmlElement.valueObject;
		for (id key in dict) {
			NSLog(@"key: %@, value: %@", key, [dict objectForKey:key]);
		}
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
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

- (void)updateDictionary {
	XmlElement *currentXE = [self currentXmlElement];
	XmlElement *enclosingXE = [self enclosingXmlElement];
	
	if (enclosingXE) {
		if (enclosingXE.type == XmlElementTypeDictionary) {
			[(NSMutableDictionary *)enclosingXE.valueObject setObject:currentXE.valueObject forKey:currentXE.name];
		} else if (enclosingXE.type = XmlElementTypeArray) {
			[(NSMutableArray *)enclosingXE.valueObject addObject:currentXE.valueObject];
		}
	}
	else {
		[xmlDict setObject:currentXE.valueObject forKey:currentXE.name];
	}
}

// XML element that is currently parsed
- (XmlElement *)currentXmlElement {
	return [elements_stack top] ? (XmlElement *)[elements_stack top] : nil;
}

- (NSString *)currentXmlElementName {
	return [elements_stack top] ? ((XmlElement *)[elements_stack top]).name : @"";
}

// XML element that encloses currentXmlElement
- (XmlElement *)enclosingXmlElement {
	return [elements_stack belowTop] ? (XmlElement *)[elements_stack belowTop] : nil;
}

- (NSString *)enclosingXmlElementName {
	return [elements_stack belowTop] ? ((XmlElement *)[elements_stack belowTop]).name : @"";
}

@end
