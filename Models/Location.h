//
//  Location.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Location : NSObject {
	NSString *label;
	NSString *ownerName;
	NSString *address;
}

@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSString *ownerName;
@property (nonatomic, retain) NSString *address;

@end
