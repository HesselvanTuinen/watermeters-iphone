//
//  LocationsRequest.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractRequest.h"


@interface LocationsRequest : AbstractRequest {
	NSMutableString *label, *address, *owner_name;
}

@end
