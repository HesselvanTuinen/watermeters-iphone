//
//  XmlParser.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "XmlElement.h"


@interface XmlParser : NSObject {
	NSXMLParser *xml_parser;
	NSMutableDictionary *xml_dict;

	Stack *elements_stack;
	BOOL done;
}

- (NSDictionary *)parseXml:(NSString *)xml;

+ (NSDictionary *)parseXml:(NSString *)xml;

@end
