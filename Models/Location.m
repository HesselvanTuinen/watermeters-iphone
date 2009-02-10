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

- (void)dealloc {
	[label release];
	[ownerName release];
	[address release];
	
	[super dealloc];
}

@end
