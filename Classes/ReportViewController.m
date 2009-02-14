//
//  ReportViewController.m
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ReportViewController.h"
#import "ReadCell.h"
#import "NewReportRequest.h"
#import "ShowReportRequest.h"
#import "UpdateReportRequest.h"


@interface ReportViewController (Private)
- (Read *)readForWatermeter:(NSInteger)watermeter_id report:(NSInteger)report_id;
@end


@implementation ReportViewController

@synthesize readsTableView;
@synthesize reportId, locationId, report, reads;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Report request
	NewReportRequest *newReportRequest = [[NewReportRequest alloc] initWithLocation:self.locationId];
	self.report = [[newReportRequest doRequest] objectAtIndex:0];
	[newReportRequest release];
	
	// Report request with reads
	ShowReportRequest *showReportRequest = [[ShowReportRequest alloc] initWithReport:self.reportId location:self.locationId];
	Report *reportWithReads = [[[showReportRequest doRequest] objectAtIndex:0] retain];
	
	self.reads = reportWithReads.reads;
	self.navigationItem.title = reportWithReads.officialDate;
	
	[showReportRequest release];
	[reportWithReads release];

	// Replace reads in self.report with the reads from reportWithReads
	Room *room;
	Watermeter *watermeter;
	for (room in self.report.location.rooms) {
		for (watermeter in room.watermeters) {
			watermeter.read = [self readForWatermeter:watermeter.pk report:self.reportId];
		}
	}
	
	// Save button
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onSave:)];
	self.navigationItem.rightBarButtonItem = barButtonItem;
	[barButtonItem release];
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

    return cell;
}


#pragma mark -
#pragma mark Private methods

- (Read *)readForWatermeter:(NSInteger)watermeter_id report:(NSInteger)report_id {
	for (Read *read in self.reads) {
		if (read.watermerId == watermeter_id && read.reportId == report_id) {
			return read;
		}
	}
	return nil;
}

#pragma mark -
#pragma mark IBActions methods

- (IBAction)onSave:(id)sender {
	// Save report changes
	UpdateReportRequest *updateReportRequest = [[UpdateReportRequest alloc] initWithLocation:self.locationId report:self.reportId reads:self.reads];
	[updateReportRequest doRequest];
	[updateReportRequest release];
	
	// Clear report cache
	[[[[ShowReportRequest alloc] initWithReport:self.reportId location:self.locationId] autorelease] clearCache];
}


- (void)dealloc {
	[readsTableView release];
	[report release];
	[reads release];

    [super dealloc];
}


@end
