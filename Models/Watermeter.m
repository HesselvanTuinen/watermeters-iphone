//
//  Watermeter.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Watermeter.h"


@implementation Watermeter

@synthesize label, roomId;

- (void)dealloc {
	[label release];
	
	[super dealloc];
}

@end
