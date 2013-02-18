/*****************************************************************
 M3PreferencesWindowExampleWindowController.m
 M3AppKit
 
 Created by Martin Pilkington on 12/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3PreferencesWindowExampleWindowController.h"

#import "M3PreferenceGeneralViewController.h"
#import "M3PreferenceAdvancedViewController.h"

@implementation M3PreferencesWindowExampleWindowController

- (id)init {
	if ((self = [super initWithWindowNibName:@"M3PreferencesWindowExampleWindow"])) {
		
	}
	return self;
}

- (void)windowDidLoad {
	M3PreferencesWindow *window = (id)self.window;
	[window setSections:@[
		[M3PreferenceGeneralViewController new],
		[M3PreferenceAdvancedViewController new]
	]];
}

@end
