/*****************************************************************
 M3NavigationContentViewController.h
 M3AppKit
 
 Created by Martin Pilkington on 14/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

@interface M3NavigationContentViewController : NSViewController <M3NavigationViewController>

- (id)initWithTitle:(NSString *)aTitle;

@property (weak) IBOutlet NSTextField *textField;
- (IBAction)nextView:(id)sender;

@end
