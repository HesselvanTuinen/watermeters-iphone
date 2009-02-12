//
//  Report.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Report.h"


@implementation Report

@synthesize locationId, officialDate;
@synthesize reads, location;

- (void)dealloc {
	[reads release];
	[location release];
	
	[super dealloc];
}

+ (Report *)reportFromDictionary:(NSDictionary *)dictionary {
	Report *report = [[Report alloc] init];
	report.pk = [(NSString *)[dictionary objectForKey:@"id"] intValue];
	report.officialDate = [dictionary objectForKey:@"official-date"];
	report.locationId = [(NSString *)[dictionary objectForKey:@"location-id"] intValue];
	return [report autorelease];
}

@end
