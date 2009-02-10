//
//  SettingsViewController.h
//  Watermeters
//
//  Created by Radu Cojocaru on 10Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField *usernameTextField;
	IBOutlet UITextField *passwordTextField;
}

@property (nonatomic, retain) IBOutlet UITextField *usernameTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;

- (IBAction)onSaveCredentials:(id)sender;
- (IBAction)onDone:(id)sender;
- (IBAction)onClearCache:(id)sender;

@end
