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
@synthesize reads;

- (void)dealloc {
	[reads release];
	
	[super dealloc];
}

@end
