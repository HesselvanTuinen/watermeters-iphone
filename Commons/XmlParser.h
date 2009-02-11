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
	NSXMLParser *parser;
	Stack *elements_stack;
	NSMutableDictionary *xml_dict;
	BOOL done;
}



@end
