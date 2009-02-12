//
//  NewReport.h
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewReportViewController : UIViewController {
	IBOutlet UITableView *readsTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *readsTableView;

- (IBAction)onCancel:(id)sender;
- (IBAction)onSave:(id)sender;

@end
