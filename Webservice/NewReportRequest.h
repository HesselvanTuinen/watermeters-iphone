//
//  NewReportRequest.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractRequest.h"


@interface NewReportRequest : AbstractRequest {
	NSInteger locationId;

	NSMutableDictionary *locationDictionary;

	// Location
	//NSMutableString *location_id, *location_label, *location_address, *location_owner_name;
	
	// Rooms
	//NSMutableArray *rooms;
	//NSMutableString *room_id, *room_label, *room_location_id;
	
	// Watermeters
	//NSMutableArray *watermeters;
	//NSMutableString *watermeter_id, *watermeter_label, *watermeter_room_id;
}

@property (nonatomic, assign) NSInteger locationId;

@end
