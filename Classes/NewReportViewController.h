//
//  NewReport.h
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Report.h"


@interface NewReportViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *readsTableView;
	Report *report;
	NSInteger locationId;
}

@property (nonatomic, retain) IBOutlet UITableView *readsTableView;
@property (nonatomic, retain) Report *report;
@property (nonatomic, assign) NSInteger locationId;

- (IBAction)onCancel:(id)sender;
- (IBAction)onSave:(id)sender;

@end
