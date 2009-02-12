//
//  Read.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractObject.h"


@interface Read : AbstractObject {
	NSInteger reportId;
	NSInteger watermerId;
	CGFloat value;
}

@property (nonatomic, assign) NSInteger reportId;
@property (nonatomic, assign) NSInteger watermerId;
@property (nonatomic, assign) CGFloat value;

+ (Read *)readWithValue:(CGFloat)value watermerId:(NSInteger)watermerId;
+ (Read *)readFromDictionary:(NSDictionary *)dictionary;

@end
