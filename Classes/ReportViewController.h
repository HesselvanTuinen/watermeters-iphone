//
//  ReportViewController.h
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Report.h"


@interface ReportViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *readsTableView;
	
	NSInteger reportId;
	NSInteger locationId;
	Report *report;
	NSArray *reads;
}

@property (nonatomic, retain) IBOutlet UITableView *readsTableView;

@property (nonatomic, assign) NSInteger reportId;
@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, retain) Report *report;
@property (nonatomic, retain) NSArray *reads;

- (IBAction)onSave:(id)sender;

@end
