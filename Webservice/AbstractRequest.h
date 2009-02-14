//
//  AbstractRequest.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AbstractRequest : NSObject {
	NSMutableString *urlString;
}

@property (nonatomic, retain) NSMutableString *urlString;

- (NSArray *)doRequest;
- (NSArray *)doRequestUsingCache:(BOOL)useCache requestMethod:(NSString *)requestMethod;

// Methods that should be implemented
- (void)generateUrlString;
- (NSArray *)parseDictionary:(NSDictionary *)dictionary;

@end
