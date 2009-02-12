//
//  NewReportRequest.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewReportRequest.h"
#import "Report.h"
#import "Location.h"
#import "Read.h"


@implementation NewReportRequest

@synthesize locationId;

- (void)generateUrlString {
	[self.urlString setString:[NSString stringWithFormat:@"http://localhost:3000/locations/%d/reports/new.xml", self.locationId]];
}

- (NSArray *)parseDictionary:(NSDictionary *)dictionary {
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	NSDictionary *reportDict = [dictionary objectForKey:@"report"];
	Report *report = [[Report alloc] init];
	report.locationId = [(NSString *)[reportDict objectForKey:@"location-id"] intValue];
	
	NSDictionary *locationDict = [reportDict objectForKey:@"location"];
	Location *location = [Location locationFromDictionary:locationDict];
	report.location = location;
	
	NSArray *rooms = [locationDict objectForKey:@"rooms"];
	NSDictionary *roomDict;
	for (roomDict in rooms) {
		Room *room = [Room roomFromDictionary:roomDict];
		NSArray *watermeters = [roomDict objectForKey:@"watermeters"];
		NSDictionary *watermeterDict;
		for (watermeterDict in watermeters) {
			Watermeter *watermeter = [Watermeter watermeterFromDictionary:watermeterDict];
			watermeter.read = [Read readWithValue:0 watermerId:watermeter.pk];
			[room addWatermeter:watermeter];
		}
		[report.location addRoom:room];
	}
	
	[results addObject:report];
	[report release];
	
	return results;
}

@end
