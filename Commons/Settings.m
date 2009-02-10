//
//  Settings.m
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"


@implementation Settings

+ (NSString *)username {
	return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}

+ (NSString *)password {
	return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

+ (void)saveUsername:(NSString *)username andPassword:(NSString *)password {
	[[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
	[[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
}

@end
