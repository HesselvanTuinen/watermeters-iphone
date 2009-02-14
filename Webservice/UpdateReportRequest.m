//
//  UpdateReportRequest.m
//  Watermeters
//
//  Created by Radu Cojocaru on 13Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UpdateReportRequest.h"
#import "Read.h"


@implementation UpdateReportRequest

@synthesize reads, locationId, reportId;

- (id)initWithLocation:(NSInteger)location_id report:(NSInteger)report_id reads:(NSArray *)readsArray {
	if (self = [super init]) {
		self.reads = readsArray;
		self.locationId = location_id;
		self.reportId = report_id;
	}
	return self;
}

- (NSArray *)doRequest {
	return [self doRequestUsingCache:NO requestMethod:@"PUT"];
}

- (void)generateUrlString {
	[self.urlString setString:[NSString stringWithFormat:@"http://localhost:3000/locations/%d/reports/%d.xml?", self.locationId, self.reportId]];
	for (Read *read in self.reads) {
		[self.urlString appendString:[NSString stringWithFormat:@"read[%d]=%.3f&", read.pk, read.value]];
	}
}

- (NSArray *)parseDictionary:(NSDictionary *)dictionary {
	return [NSArray array];
}

- (void)dealloc {
	[reads release];

	[super dealloc];
}

@end
