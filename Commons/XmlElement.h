//
//  XmlElement.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    XmlElementTypeDictionary,
	XmlElementTypeArray,
	XmlElementTypeItem,
	XmlElementTypeUnkown
} XmlElementType;

@interface XmlElement : NSObject {
	NSString *name;
	XmlElementType type;
	id valueObject;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) XmlElementType type;
@property (nonatomic, retain) id valueObject;

+ (id)elementWithName:(NSString *)elementName;

@end
