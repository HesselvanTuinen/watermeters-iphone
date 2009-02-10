//
//  Stack.m
//  Watermeters
//
//  Created by Radu Cojocaru on 12/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Stack.h"


@implementation Stack


#pragma mark Initialization and deallocation methods


// Initialize an empty stack 
- (id)init {
	if (self = [super init]) {
		stack = [[NSMutableArray alloc] init];
	}
	return self;
}


// Release the stack
- (void)dealloc {
	[stack release];
	
	[super dealloc];
}

# pragma mark Destructive methods

// Get the object at the top of the stack and remove it from the stack
- (id)pop {
	if ([stack count] == 0) {
		return nil;
	}
	else {
		id anObject = [[stack objectAtIndex:0] retain];
		[stack removeObjectAtIndex:0];
		return [anObject autorelease];
	}
}


// Push an object on top of the stack
- (void)push:(id)anObject {
	[stack insertObject:anObject atIndex:0];
}

# pragma mark 'Take a look' methods

// Get a reference to the object on top of the stack
- (id)top {
	return [stack count] > 0 ? [stack objectAtIndex:0] : nil;
}


// Get a reference to the object just below to the object on top of the stack
- (id)belowTop {
	return [stack count] > 1 ? [stack objectAtIndex:1] : nil;
}


@end
