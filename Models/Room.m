//
//  Room.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Room.h"


@implementation Room

@synthesize label, locationId;
@synthesize watermeters;

- (void)dealloc {
	[label release];
	
	[watermeters release];
	
	[super dealloc];
}

- (void)addWatermeter:(Watermeter *)watermeter {
	NSMutableArray *newWatermeters = [NSMutableArray arrayWithArray:self.watermeters];
	[newWatermeters addObject:watermeter];
	self.watermeters = newWatermeters;
}

+ (Room *)roomFromDictionary:(NSDictionary *)dictionary {
	Room *room = [[Room alloc] init];
	room.pk = [(NSString *)[dictionary objectForKey:@"id"] intValue];
	room.locationId = [(NSString *)[dictionary objectForKey:@"location-id"] intValue];
	room.label = [dictionary objectForKey:@"label"];
	return [room autorelease];
}

@end
