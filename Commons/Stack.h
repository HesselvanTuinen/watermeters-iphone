//
//  Stack.h
//  Watermeters
//
//  Created by Radu Cojocaru on 12/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Stack : NSObject {
	NSMutableArray *stack;
}

- (id)pop;					// Get the object at the top of the stack and remove it from the stack
- (void)push:(id)anObject;	// Push an object on top of the stack

- (id)top;		// Get a reference to the object on top of the stack
- (id)belowTop;	// Get a reference to the object just below to the object on top of the stack

@end
