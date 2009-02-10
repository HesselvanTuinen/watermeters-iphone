//
//  WatermetersAppDelegate.m
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "WatermetersAppDelegate.h"
#import "LocationsViewController.h"
#import "RestfulObject.h"


@implementation WatermetersAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[RestfulObject ensureCacheStoreExists];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
