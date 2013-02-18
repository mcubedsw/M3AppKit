/*****************************************************************
 M3PreferenceGeneralViewController.m
 M3AppKit
 
 Created by Martin Pilkington on 13/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3PreferenceGeneralViewController.h"

@implementation M3PreferenceGeneralViewController

- (id)init {
	if ((self = [super initWithNibName:@"M3PreferenceGeneralView" bundle:nil])) {
		
	}
	return self;
}

- (NSImage *)toolbarIcon {
	return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)title {
	return @"General";
}

@end
