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

- (NSArray *)parseDictionary:(NSDictionary *)dictionary {
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	NSArray *locations = [dictionary objectForKey:@"locations"];
	NSDictionary *locationDict;
	for (locationDict in locations) {
		Location *location = [Location locationFromDictionary:locationDict];
		[results addObject:location];
	}
	
	return results;
}

@end
