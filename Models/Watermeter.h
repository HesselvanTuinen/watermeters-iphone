//
//  Watermeter.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractObject.h"
#import "Read.h"


@interface Watermeter : AbstractObject {
	NSString *label;
	NSInteger roomId;
	
	Read *read;
}

@property (nonatomic, retain) NSString *label;
@property (nonatomic, assign) NSInteger roomId;

@property (nonatomic, retain) Read *read;

+ (Watermeter *)watermeterFromDictionary:(NSDictionary *)dictionary;

@end
