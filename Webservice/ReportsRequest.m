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

- (id)initWithLocation:(NSInteger)new_location_id {
	if (self = [super init]) {
		self.locationId = new_location_id;
	}
	return self; 
}

- (void)generateUrlString {
	[self.urlString setString:[NSString stringWithFormat:@"%@/locations/%d/reports.xml", WEBSERVICE_HOSTNAME, self.locationId]];
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
