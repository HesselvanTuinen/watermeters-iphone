//
//  Room.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractObject.h"


@interface Room : AbstractObject {
	NSString *label;
	NSInteger locationId;
}

@property (nonatomic, retain) NSString *label;
@property (nonatomic, assign) NSInteger locationId;

@end
