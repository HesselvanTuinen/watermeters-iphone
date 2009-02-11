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

- (void)dealloc {
	[label release];
	
	[super dealloc];
}

@end
