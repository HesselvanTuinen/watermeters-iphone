//
//  Read.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Read.h"


@implementation Read

@synthesize reportId, watermerId, value;

+ (Read *)readWithValue:(CGFloat)value watermerId:(NSInteger)watermerId {
	Read *read = [[Read alloc] init];
	read.value = value;
	read.watermerId = watermerId;
	return [read autorelease];
}

@end
