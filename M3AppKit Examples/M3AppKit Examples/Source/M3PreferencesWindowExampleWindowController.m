//
//  M3PreferencesWindowExampleWindowController.m
//  M3AppKit Examples
//
//  Created by Martin Pilkington on 12/02/2013.
//  Copyright (c) 2013 M Cubed Software Ltd. All rights reserved.
//

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
