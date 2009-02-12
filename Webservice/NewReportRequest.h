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
}

@property (nonatomic, assign) NSInteger locationId;

- (id)initWithLocation:(NSInteger)location_id;

@end
