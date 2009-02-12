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

+ (Watermeter *)watermeterFromDictionary:(NSDictionary *)dictionary {
	Watermeter *watermeter = [[Watermeter alloc] init];
	watermeter.pk = [(NSString *)[dictionary objectForKey:@"id"] intValue];
	watermeter.label = [dictionary objectForKey:@"label"];
	watermeter.roomId = [(NSString *)[dictionary objectForKey:@"room-id"] intValue];
	return [watermeter autorelease];
}

@end
