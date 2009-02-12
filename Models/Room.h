//
//  Room.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractObject.h"
#import "Watermeter.h"


@interface Room : AbstractObject {
	NSString *label;
	NSInteger locationId;
	
	NSArray *watermeters;
}

@property (nonatomic, retain) NSString *label;
@property (nonatomic, assign) NSInteger locationId;

@property (nonatomic, retain) NSArray *watermeters;

- (void)addWatermeter:(Watermeter *)watermeter;

+ (Room *)roomFromDictionary:(NSDictionary *)dictionary;

@end
