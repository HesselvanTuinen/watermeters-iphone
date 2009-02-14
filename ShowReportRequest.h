//
//  ShowReportRequest.h
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractRequest.h"


@interface ShowReportRequest : AbstractRequest {
	NSInteger reportId;
	NSInteger locationId;
}

@property (nonatomic, assign) NSInteger reportId;
@property (nonatomic, assign) NSInteger locationId;

- (id)initWithReport:(NSInteger)report_id location:(NSInteger)location_id;
- (void)clearCache;

@end
