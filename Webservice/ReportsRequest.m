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

- (id)initWithLocation:(NSInteger)location_id {
	if (self = [super init]) {
		self.locationId = location_id;
	}
	return self;
}

- (void)generateUrlString {
	[self.urlString setString:[NSString stringWithFormat:@"http://localhost:3000/locations/%d/reports.xml", self.locationId]];
}

- (NSArray *)parseDictionary:(NSDictionary *)dictionary {
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	NSArray *reports = [dictionary objectForKey:@"reports"];
	NSDictionary *reportDict;
	for (reportDict in reports) {
		Report *report = [[Report alloc] init];
		report.pk = [(NSString *)[reportDict objectForKey:@"id"] intValue];
		report.locationId = [(NSString *)[reportDict objectForKey:@"location-id"] intValue];
		report.officialDate = [reportDict objectForKey:@"official-date"];
		
		[results addObject:report];
		[report release];
	}
	
	return results;
}

@end
