//
//  XmlParser.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XmlParser.h"

@interface XmlParser (Private)
- (void)setupParser:(NSData *)data;
- (void)updateDictionary;
- (XmlElement *)currentXmlElement;
- (XmlElement *)enclosingXmlElement;
@end

@implementation XmlParser

- (NSDictionary *)parseXml:(NSString *)xml {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	// Setup parser and start parsing
	const char *axml = [xml UTF8String];
	[self setupParser:[NSData	dataWithBytes:axml length:strlen(axml)]];
	[xml_parser parse];
	
	// Wait for parsing end
	NSRunLoop *loop = [NSRunLoop currentRunLoop];
	while (!done) {
		[loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
	}
	
	[xml_parser release];
	
	[pool release];
	
	return [xml_dict autorelease];
}

- (void)setupParser:(NSData *)data {
	xml_parser = [[NSXMLParser alloc] init];
	[xml_parser initWithData:data];
	[xml_parser setDelegate:self];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
}

#pragma mark -
#pragma mark NSXMLParser delegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	done = NO;
	xml_dict = [[NSMutableDictionary alloc] init];
	elements_stack = [[Stack alloc] init];
}

- (void)parser:(NSXMLParser *)parse parseErrorOccurred:(NSError *)parseError {
	NSLog(@"error parsing XML: %d", [parseError code]);
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
	[elements_stack pop];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	done = YES;
	[elements_stack release];
}

#pragma mark -
#pragma mark Private methods

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
		[xml_dict setObject:currentXE.valueObject forKey:currentXE.name];
	}
}

// XML element that is currently parsed
- (XmlElement *)currentXmlElement {
	return [elements_stack top] ? (XmlElement *)[elements_stack top] : nil;
}

// XML element that encloses currentXmlElement
- (XmlElement *)enclosingXmlElement {
	return [elements_stack belowTop] ? (XmlElement *)[elements_stack belowTop] : nil;
}

#pragma mark -
#pragma mark Class methods

+ (NSDictionary *)parseXml:(NSString *)xml {
	XmlParser *xml_parser = [[XmlParser alloc] init];
	NSDictionary *dict = [[xml_parser parseXml:xml] retain];
	[xml_parser release];
	
	return [dict autorelease];
}

@end
