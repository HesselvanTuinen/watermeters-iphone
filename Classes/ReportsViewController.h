//
//  ReportsViewController.h
//  Watermeters
//
//  Created by Radu Cojocaru on 11Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "Report.h"


@interface ReportsViewController : UIViewController {
	IBOutlet UITableView *reportsTableView;
	IBOutlet UILabel *addressLabel;
	IBOutlet UILabel *ownerLabel;
	
	Location *location;
	NSArray *reports;
}

@property (nonatomic, retain) IBOutlet UITableView *reportsTableView;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UILabel *ownerLabel;

@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSArray *reports;

@end
