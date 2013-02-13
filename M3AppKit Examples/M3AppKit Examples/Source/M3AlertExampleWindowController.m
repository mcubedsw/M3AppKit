//
//  M3AlertExampleWindowController.m
//  M3AppKit Examples
//
//  Created by Martin Pilkington on 12/02/2013.
//  Copyright (c) 2013 M Cubed Software Ltd. All rights reserved.
//

#import "M3AlertExampleWindowController.h"

@implementation M3AlertExampleWindowController

- (id)init {
	if ((self = [super initWithWindowNibName:@"M3AlertExampleWindow"])) {
		
	}
	return self;
}

- (IBAction)showAlert:(id)sender {
	//Sadly we need to cast to id as NSAlert doesn't use instancetype
	M3Alert *alert = (id)[M3Alert alertWithMessageText:@"This is an example alert"
										 defaultButton:@"OK"
									   alternateButton:@"Apathy"
										   otherButton:@"Cancel"
							 informativeTextWithFormat:@"This is an example of an M3Alert"];
	
	[alert beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		NSLog(@"Result of alert is:%ld", (long)result);
	}];
}

@end
