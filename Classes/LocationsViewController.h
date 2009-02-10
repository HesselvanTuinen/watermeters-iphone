//
//  LocationsViewController.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LocationsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *locationsTableView;
	
	NSArray *locations;
}

@property (nonatomic, retain) IBOutlet UITableView *locationsTableView;

@property (nonatomic, retain) NSArray *locations;

@end
