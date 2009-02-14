//
//  LocationsViewController.m
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LocationsViewController.h"
#import "SettingsViewController.h"
#import "LocationsRequest.h"
#import "Location.h"
#import "ReportsViewController.h"


@implementation LocationsViewController

@synthesize locationsTableView;
@synthesize locations;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// View title
	self.navigationItem.title = @"Locations";
	
	// Setting buttons
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(onSettingsShow)];
	self.navigationItem.rightBarButtonItem = barButtonItem;
	[barButtonItem release];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// Locations
	@try {
		LocationsRequest *locationsRequest = [[LocationsRequest alloc] init];
		self.locations = [locationsRequest doRequest];
		[locationsRequest release];
		[self.locationsTableView reloadData];
	}
	@catch (NSException * e) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Authentication failed" message:@"Open Settings to fill in your username and password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [locations count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"LocationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell
	Location *location = (Location *)[self.locations objectAtIndex:indexPath.row];
	cell.text = location.label;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

// Show reports for selected location
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ReportsViewController *rvc = [[ReportsViewController alloc] initWithNibName:@"ReportsView" bundle:nil];
	Location *location = (Location *)[self.locations objectAtIndex:indexPath.row];
	rvc.location = location;
	[self.navigationController pushViewController:rvc animated:YES];
	[rvc release];
}


- (void)dealloc {
	[locationsTableView release];
	
	[locations release];
	
    [super dealloc];
}


- (void)onSettingsShow {
	SettingsViewController *svc = [[SettingsViewController alloc] initWithNibName:@"SettingsView" bundle:nil];
	[self presentModalViewController:svc animated:YES];
	[svc release];
}


@end
