//
//  NewReportRequest.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewReportRequest.h"


@implementation NewReportRequest

@synthesize locationId;

- (void)generateUrlString {
	[self.urlString setString:[NSString stringWithFormat:@"http://localhost:3000/locations/%d/reports/new.xml", self.locationId]];
}

- (void)initCurrent {
	if ([[self currentXmlElement] isEqualToString:@"location"]) {
		locationDictionary = [NSMutableDictionary dictionaryWithCapacity:3];
		//location_id = [[NSMutableString alloc] init];
		//location_label = [[NSMutableString alloc] init];
		//location_address = [[NSMutableString alloc] init];
		//location_owner_name = [[NSMutableString alloc] init];
	}
	else if ([[self currentXmlElement] isEqualToString:@"rooms"]) {
		//rooms = [[NSMutableArray alloc] initWithCapacity:5];
	}
	else if ([[self currentXmlElement] isEqualToString:@"room"]) {
		//room_id = [[NSMutableString alloc] init];
		//room_label = [[NSMutableString alloc] init];
		//room_location_id = [[NSMutableString alloc] init];
	}
	else if ([[self currentXmlElement] isEqualToString:@"watermeters"]) {
		//watermeters = [[NSMutableArray alloc] initWithCapacity:5];
	}
	else if ([[self currentXmlElement] isEqualToString:@"watermeter"]) {
		//watermeter_id = [[NSMutableString alloc] init];
		//watermeter_label = [[NSMutableString alloc] init];
		//watermeter_room_id = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if ([[self enclosingXmlElement] isEqualToString:@"location"]) {
		NSMutableString *value = [locationDictionary objectForKey:[self currentXmlElement]];
		if (value == nil) {
			value = [[NSMutableString alloc] init];
		}
		[value appendString:string];
	}
}

@end
