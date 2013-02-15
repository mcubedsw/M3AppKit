//
//  M3NavigationContentViewController.m
//  M3AppKit Examples
//
//  Created by Martin Pilkington on 14/02/2013.
//  Copyright (c) 2013 M Cubed Software Ltd. All rights reserved.
//

#import "M3NavigationContentViewController.h"

@implementation M3NavigationContentViewController

@synthesize navigationView;

- (id)initWithTitle:(NSString *)aTitle {
	if ((self = [super initWithNibName:@"M3NavigationContentView" bundle:nil])) {
		[self setTitle:aTitle];
	}
	return self;
}

- (void)awakeFromNib {
	[self.textField setStringValue:self.title];
}

- (IBAction)nextView:(id)sender {
	M3NavigationContentViewController *controller = [[M3NavigationContentViewController alloc] initWithTitle:self.textField.stringValue];
	[self.navigationView pushViewController:controller animated:YES];
}

@end
