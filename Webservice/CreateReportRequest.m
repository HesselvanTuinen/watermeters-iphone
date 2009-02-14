//
//  CreateReportRequest.m
//  Watermeters
//
//  Created by Radu Cojocaru on 14Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CreateReportRequest.h"
#import "Read.h"


@implementation CreateReportRequest

@synthesize locationId, reads;

- (id)initWithLocation:(NSInteger)location_id reads:(NSArray *)readsArray {
	if (self = [super init]) {
		self.locationId = location_id;
		self.reads = readsArray;
	}
	return self;
}

- (NSArray *)doRequest {
	return [self doRequestUsingCache:NO requestMethod:@"POST"];
}

- (void)generateUrlString {
	[self.urlString setString:[NSString stringWithFormat:@"http://localhost:3000/locations/%d/reports.xml?", self.locationId]];
	for (Read *read in self.reads) {
		[self.urlString appendString:[NSString stringWithFormat:@"value_for_watermeter[%d]=%.3f&", read.watermerId, read.value]];
	}
	NSLog(@"url = %@", self.urlString);
}

- (NSArray *)parseDictionary:(NSDictionary *)dictionary {
	return [NSArray array];
}

- (void)dealloc {
	[reads release];
	
	[super dealloc];
}

@end
