//
//  M3NavigationViewExampleWindowController.m
//  M3AppKit Examples
//
//  Created by Martin Pilkington on 12/02/2013.
//  Copyright (c) 2013 M Cubed Software Ltd. All rights reserved.
//

#import "M3NavigationViewExampleWindowController.h"
#import "M3NavigationContentViewController.h"

@implementation M3NavigationViewExampleWindowController

- (id)init {
	if ((self = [super initWithWindowNibName:@"M3NavigationViewExampleWindow"])) {
		
	}
	return self;
}

- (void)awakeFromNib {
	[self.navigationView pushViewController:[[M3NavigationContentViewController alloc] initWithTitle:@"First View"] animated:NO];
}


@end
