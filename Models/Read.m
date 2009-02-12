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

+ (Read *)readFromDictionary:(NSDictionary *)dictionary {
	Read *read = [[Read alloc] init];
	read.pk = [(NSString *)[dictionary objectForKey:@"id"] intValue];
	read.reportId = [(NSString *)[dictionary objectForKey:@"report-id"] intValue];
	read.watermerId = [(NSString *)[dictionary objectForKey:@"watermeter-id"] intValue];
	read.value = [(NSString *)[dictionary objectForKey:@"value"] floatValue];
	return [read autorelease];
}

@end
