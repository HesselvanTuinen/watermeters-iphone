//
//  Report.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractObject.h"


@interface Report : AbstractObject {
	NSInteger locationId;
	NSString *officialDate;
}

@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, retain) NSString *officialDate;

@end
