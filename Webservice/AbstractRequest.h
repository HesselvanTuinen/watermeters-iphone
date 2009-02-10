//
//  AbstractRequest.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"


@interface AbstractRequest : NSObject {
	NSMutableString *urlString;
	NSXMLParser *requestParser;
	NSMutableArray *results;
	Stack *elements_stack;
	Boolean done;
}

@property (nonatomic, retain) NSMutableString *urlString;
@property (nonatomic, retain) NSXMLParser *requestParser;
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, assign) Boolean done;

- (void)generateUrlString;
- (NSArray *)doRequest;
- (NSArray *)doRequestusingCache:(BOOL)useCache;
- (NSArray *)parseXml:(NSString *)xml;
- (void)initCurrent;
- (void)initCurrent:(NSDictionary *)attributeDict;

- (NSString *)currentXmlElement;
- (NSString *)enclosingXmlElement; // element that encloses currentXmlElement

@end
