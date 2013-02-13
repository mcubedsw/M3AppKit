//
//  M3PreferenceGeneralViewController.m
//  M3AppKit Examples
//
//  Created by Martin Pilkington on 13/02/2013.
//  Copyright (c) 2013 M Cubed Software Ltd. All rights reserved.
//

#import "M3PreferenceGeneralViewController.h"

@implementation M3PreferenceGeneralViewController

- (id)init {
	if ((self = [super initWithNibName:@"M3PreferenceGeneralView" bundle:nil])) {
		
	}
	return self;
}

- (NSImage *)image {
	return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)title {
	return @"General";
}

@end
