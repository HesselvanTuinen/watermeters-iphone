//
//  Location.m
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Location.h"


@implementation Location

@synthesize label, ownerName, address;
@synthesize rooms;

- (void)dealloc {
	[label release];
	[ownerName release];
	[address release];
	
	[rooms release];
	
	[super dealloc];
}

- (void)addRoom:(Room *)room {
	NSMutableArray *newRooms = [NSMutableArray arrayWithArray:self.rooms];
	[newRooms addObject:room];
	self.rooms = newRooms;
}

+ (Location *)locationFromDictionary:(NSDictionary *)dictionary {
	Location *location = [[Location alloc] init];
	location.pk = [(NSString *)[dictionary objectForKey:@"id"] intValue];
	location.label = [dictionary objectForKey:@"label"];
	location.address = [dictionary objectForKey:@"address"];
	location.ownerName = [dictionary objectForKey:@"owner-name"];
	return [location autorelease];
}

@end
