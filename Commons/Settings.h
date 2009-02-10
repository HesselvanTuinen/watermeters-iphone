//
//  Settings.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Settings : NSObject {

}

+ (NSString *)username;
+ (NSString *)password;
+ (void)saveUsername:(NSString *)username andPassword:(NSString *)password;

@end
