//
//  Location.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractObject.h"


@interface Location : AbstractObject {
	NSString *label;
	NSString *ownerName;
	NSString *address;
	
	NSArray *rooms;
}

@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSString *ownerName;
@property (nonatomic, retain) NSString *address;

@property (nonatomic, retain) NSArray *rooms;

@end
