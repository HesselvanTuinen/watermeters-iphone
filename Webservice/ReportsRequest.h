//
//  ReportsRequest.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractRequest.h"


@interface ReportsRequest : AbstractRequest {
	NSInteger locationId;

	NSMutableString *pk, *location_id, *official_date;
}

@property (nonatomic, assign) NSInteger locationId;

@end
