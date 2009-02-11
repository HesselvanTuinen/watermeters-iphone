//
//  XmlElement.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XmlElement.h"

@implementation XmlElement

@synthesize name, type, valueObject;

+ (id)elementWithName:(NSString *)elementName {
	XmlElement *xe = [[XmlElement alloc] init];
	xe.name = elementName;
	xe.type = XmlElementTypeUnkown;
	return [xe autorelease];
}

- (void)dealloc {
	[name release];
	[valueObject release];

	[super dealloc];
}

@end
