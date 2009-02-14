//
//  CreateReportRequest.h
//  Watermeters
//
//  Created by Radu Cojocaru on 14Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractRequest.h"


@interface CreateReportRequest : AbstractRequest {
	NSInteger locationId;
	NSArray *reads;
}

@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, retain) NSArray *reads;

- (id)initWithLocation:(NSInteger)location_id reads:(NSArray *)readsArray;

@end
