//
//  ReadCell.m
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ReadCell.h"


@implementation ReadCell

@synthesize watermeter_label, value_text_field, read, hideKeyboardOnReturn, delegate;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		self.hideKeyboardOnReturn = YES;
		
		// Label
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 30)];
		label.font = [UIFont systemFontOfSize:16.0];
		self.watermeter_label = label;
		[self addSubview:watermeter_label];
		[label release];
		
        // TextField
		UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(210, 8, 80, 30)];
		textField.font = [UIFont systemFontOfSize:16.0];
		textField.borderStyle = UITextBorderStyleRoundedRect;
		textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		textField.delegate = self;
		self.value_text_field = textField;
		[self addSubview:value_text_field];
		[textField release];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onValueChanged:) name:UITextFieldTextDidChangeNotification object:value_text_field];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (void)dealloc {
	[watermeter_label release];
	[value_text_field release];
	if (read) [read release];

    [super dealloc];
}
		
		
- (void)setLabel:(NSString *)text {
	self.watermeter_label.text = text;
}


- (void)setEditFocus {
	[self.value_text_field becomeFirstResponder];
}


- (void)setRead:(Read *)newRead {
	if (read) [read release];
	read = [newRead retain];
	self.value_text_field.text = read.value != 0 ? [NSString stringWithFormat:@"%.3f", read.value] : @"";
}

#pragma mark -
#pragma mark UITextField notifications handling

- (void)onValueChanged:(id)sender {
	self.read.value = [value_text_field.text floatValue];
}

#pragma mark -
#pragma mark UITextField delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (self.hideKeyboardOnReturn) {
		[textField resignFirstResponder];
		if (delegate && [delegate respondsToSelector:@selector(closeKeyboard)]) {
			[delegate closeKeyboard];
		}
	}
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	if (delegate && [delegate respondsToSelector:@selector(openKeyboardForCell:)]) {
		[delegate openKeyboardForCell:self];
	}
}

@end
