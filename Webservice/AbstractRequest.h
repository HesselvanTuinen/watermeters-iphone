//
//  AbstractRequest.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "XmlElement.h"


@interface AbstractRequest : NSObject {
	NSMutableString *urlString;
	NSMutableArray *results;
}

@property (nonatomic, retain) NSMutableString *urlString;
@property (nonatomic, retain) NSXMLParser *requestParser;
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, assign) Boolean done;

- (void)generateUrlString;
- (NSArray *)doRequest;
- (NSArray *)doRequestUsingCache:(BOOL)useCache;
- (NSArray *)parseXml:(NSString *)xml;
- (void)initCurrent;
- (void)initCurrent:(NSDictionary *)attributeDict;



@end
