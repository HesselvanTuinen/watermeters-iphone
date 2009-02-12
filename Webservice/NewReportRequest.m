//
//  NewReportRequest.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewReportRequest.h"
#import "Report.h"


@implementation NewReportRequest

@synthesize locationId;

- (void)generateUrlString {
	[self.urlString setString:[NSString stringWithFormat:@"http://localhost:3000/locations/%d/reports/new.xml", self.locationId]];
}

- (NSArray *)parseDictionary:(NSDictionary *)dictionary {
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	NSDictionary *reportDict = [dictionary objectForKey:@"report"];
	//Report *report = [[Report alloc] init];
	
	return results;
}

@end
