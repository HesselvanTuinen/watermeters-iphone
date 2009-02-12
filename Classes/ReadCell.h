//
//  ReadCell.h
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ReadCell : UITableViewCell {
	UILabel *watermeter_label;
	UITextField *value_text_field;
}

@property (nonatomic, retain) UILabel *watermeter_label;
@property (nonatomic, retain) UITextField *value_text_field;

- (void)setLabel:(NSString *)text;

@end
