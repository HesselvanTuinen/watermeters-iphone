//
//  UpdateReportRequest.h
//  Watermeters
//
//  Created by Radu Cojocaru on 13Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractRequest.h"


@interface UpdateReportRequest : AbstractRequest {
	NSArray *reads;
	NSInteger locationId;
	NSInteger reportId;
}

@property (nonatomic, retain) NSArray *reads;
@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, assign) NSInteger reportId;

- (id)initWithLocation:(NSInteger)location_id report:(NSInteger)report_id reads:(NSArray *)readsArray;

@end
