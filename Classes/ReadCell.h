//
//  ReadCell.h
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Read.h"


@interface ReadCell : UITableViewCell {
	UILabel *watermeter_label;
	UITextField *value_text_field;
	Read *read;
}

@property (nonatomic, retain) UILabel *watermeter_label;
@property (nonatomic, retain) UITextField *value_text_field;
@property (nonatomic, retain) Read *read;

- (void)setLabel:(NSString *)text;
- (void)setEditFocus;

@end
