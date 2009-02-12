//
//  ReadCell.h
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ReadCell : UITableViewCell {
	UITextField *valueTextField;
}

@property (nonatomic, retain) UITextField *valueTextField;

@end
