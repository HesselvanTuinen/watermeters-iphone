//
//  NewReport.m
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewReportViewController.h"
#import "NewReportRequest.h"
#import "ReadCell.h"
#import "CreateReportRequest.h"
#import "Report.h"
#import "ReportsRequest.h"


@implementation NewReportViewController

@synthesize readsTableView, report, locationId;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	// Report request
	NewReportRequest *newReportRequest = [[NewReportRequest alloc] initWithLocation:self.locationId];
	self.report = [[newReportRequest doRequest] objectAtIndex:0];
	[newReportRequest release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark -
#pragma mark UITableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.report.location.rooms count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	Room *room = [self.report.location.rooms objectAtIndex:section];
	return room.label;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	Room *room = [self.report.location.rooms objectAtIndex:section];
    return [room.watermeters count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ReadCell";
    
    ReadCell *cell = (ReadCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ReadCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell
	Room *room = [self.report.location.rooms objectAtIndex:indexPath.section];
	Watermeter *watermeter = [room.watermeters objectAtIndex:indexPath.row];
	[cell setLabel:watermeter.label];
	[cell setRead:watermeter.read];
	
	if (indexPath.section == 0 && indexPath.row == 0) {
		[cell setEditFocus];
	}
	
    return cell;
}

#pragma mark -
#pragma mark IBActions methods

- (IBAction)onCancel:(id)sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)onSave:(id)sender {
	// Create reads array
	NSMutableArray *reads = [NSMutableArray array];
	for (Room *room in self.report.location.rooms) {
		for (Watermeter *watermeter in room.watermeters) {
			[reads addObject:watermeter.read];
		}
	}
	
	// Create report
	CreateReportRequest *createReportRequest = [[CreateReportRequest alloc] initWithLocation:self.locationId reads:reads];
	NSArray *results = [[createReportRequest doRequest] retain];
	[createReportRequest release];
	
	// Check if report was created successfully
	if ([results count] > 0 && ((Report *)[results objectAtIndex:0]).pk > 0) {
		// Clear reports list cache
		[[[[ReportsRequest alloc] initWithLocation:self.locationId] autorelease] clearCache];
		
		// Dismiss view
		[self.parentViewController dismissModalViewControllerAnimated:YES];
	}
	else {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Create Report" message:@"Error saving the new report" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
	
	[results release];
}


- (void)dealloc {
	[readsTableView release];
	[report release];
	
    [super dealloc];
}


@end
