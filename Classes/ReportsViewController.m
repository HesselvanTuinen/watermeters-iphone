//
//  ReportsViewController.m
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ReportsViewController.h"
#import "ReportsRequest.h"
#import "ReportViewController.h"


@implementation ReportsViewController

@synthesize reportsTableView, addressLabel, ownerLabel;
@synthesize location, reports;

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
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	self.navigationItem.title = self.location.label;
	
	self.addressLabel.text = self.location.address;
	self.ownerLabel.text = self.location.ownerName;
	
	// Load reports
	ReportsRequest *reportsRequest = [[ReportsRequest alloc] init];
	reportsRequest.locationId = self.location.pk;
	self.reports = [reportsRequest doRequest];
	[reportsRequest release];
	
	// 'New Report' button
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New Report" style:UIBarButtonItemStyleBordered target:self action:@selector(onNewReport)];
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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [reports count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ReportCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell
	Report *report = (Report *)[self.reports objectAtIndex:indexPath.row];
	cell.text = report.officialDate;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Report *report = (Report *)[self.reports objectAtIndex:indexPath.row];
	ReportViewController *rvc = [[ReportViewController alloc] initWithNibName:@"ReportView" bundle:nil];
	rvc.reportId = report.pk;
	[self.navigationController pushViewController:rvc animated:YES];
	[rvc release];
}

- (void)onNewReport {
	ReportViewController *rvc = [[ReportViewController alloc] initWithNibName:@"ReportView" bundle:nil];
	[self presentModalViewController:rvc animated:YES];
	[rvc release];
}


- (void)dealloc {
	[reportsTableView release];
	[addressLabel release];
	[ownerLabel release];

	[location release];
	[reports release];

    [super dealloc];
}


@end
