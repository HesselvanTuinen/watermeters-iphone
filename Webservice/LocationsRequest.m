//
//  LocationsRequest.m
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LocationsRequest.h"
#import "Location.h"


@implementation LocationsRequest

- (void)generateUrlString {
	[self.urlString setString:@"http://localhost:3000/locations.xml"];
}


- (void)initCurrent {
	if ([[self currentXmlElement] isEqualToString:@"location"]) {
		pk = [[NSMutableString alloc] init];
		label = [[NSMutableString alloc] init];
		address = [[NSMutableString alloc] init];
		owner_name = [[NSMutableString alloc] init];
	}
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if ([[self enclosingXmlElement] isEqualToString:@"location"]) {
		if ([[self currentXmlElement] isEqualToString:@"id"]) {
			[pk appendString:string];
		} else if ([[self currentXmlElement] isEqualToString:@"address"]) {
			[address appendString:string];
		} else if ([[self currentXmlElement] isEqualToString:@"label"]) {
			[label appendString:string];
		} else if ([[self currentXmlElement] isEqualToString:@"owner-name"]) {
			[owner_name appendString:string];
		}
	}
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([[self currentXmlElement] isEqualToString:@"location"]) {
		// Create Location object
		Location *location = [[Location alloc] init];
		location.pk = [pk intValue];
		location.label = label;
		location.address = address;
		location.ownerName = owner_name;
		
		// Store Location object into results array
		[results addObject:location];
		[location release];
	}
	
	[super parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName];
}

@end
