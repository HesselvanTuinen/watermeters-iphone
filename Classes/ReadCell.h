//
//  ReadCell.h
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Read.h"

@protocol ReadCellDelegate;

@interface ReadCell : UITableViewCell <UITextFieldDelegate> {
	UILabel *watermeter_label;
	UITextField *value_text_field;
	Read *read;
	BOOL hideKeyboardOnReturn;
	id delegate;
}

@property (nonatomic, retain) UILabel *watermeter_label;
@property (nonatomic, retain) UITextField *value_text_field;
@property (nonatomic, retain) Read *read;
@property (nonatomic, assign) BOOL hideKeyboardOnReturn;
@property (nonatomic, assign) id<ReadCellDelegate> delegate;

- (void)setLabel:(NSString *)text;
- (void)setEditFocus;

@end

@protocol ReadCellDelegate <NSObject>

@optional

- (void)openKeyboard;
- (void)closeKeyboard;

@end
