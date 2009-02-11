//
//  ReportsRequest.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ReportsRequest.h"
#import "Report.h"


@implementation ReportsRequest

@synthesize locationId;

- (void)generateUrlString {
	[self.urlString setString:[NSString stringWithFormat:@"http://localhost:3000/locations/%d/reports.xml", self.locationId]];
}


- (void)initCurrent {
	if ([[self currentXmlElement] isEqualToString:@"report"]) {
		pk = [[NSMutableString alloc] init];
		location_id = [[NSMutableString alloc] init];
		official_date = [[NSMutableString alloc] init];
	}
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if ([[self enclosingXmlElement] isEqualToString:@"report"]) {
		if ([[self currentXmlElement] isEqualToString:@"id"]) {
			[pk appendString:string];
		} else if ([[self currentXmlElement] isEqualToString:@"location-id"]) {
			[location_id appendString:string];
		} else if ([[self currentXmlElement] isEqualToString:@"official-date"]) {
			[official_date appendString:string];
		}
	}
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([[self currentXmlElement] isEqualToString:@"report"]) {
		// Create Report object
		Report *report = [[Report alloc] init];
		report.pk = [pk intValue];
		report.locationId = [location_id intValue];
		report.officialDate = official_date;
		
		// Store Report object into results array
		[results addObject:report];
		[report release];
	}
	
	[super parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName];
}

@end
