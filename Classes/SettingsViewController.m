//
//  SettingsViewController.m
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "RestfulObject.h"
#import "Settings.h"


@implementation SettingsViewController

@synthesize usernameTextField, passwordTextField;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	usernameTextField.text = [Settings username];
	passwordTextField.text = [Settings password];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[usernameTextField release];
	[passwordTextField release];
	
    [super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)onSaveCredentials:(id)sender {
	[Settings saveUsername:usernameTextField.text andPassword:passwordTextField.text];
}

- (IBAction)onDone:(id)sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)onClearCache:(id)sender {
	[RestfulObject clearCache];
}

@end
