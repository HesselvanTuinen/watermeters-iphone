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


@implementation NewReportViewController

@synthesize readsTableView, report, locationId;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	// Report request
	NewReportRequest *newReportRequest = [[NewReportRequest alloc] init];
	newReportRequest.locationId = self.locationId;
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
	
	// TODO: set the value in the cell textfield
	
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
	NSLog(@"save report");
}


- (void)dealloc {
	[readsTableView release];
	[report release];
	
    [super dealloc];
}


@end
