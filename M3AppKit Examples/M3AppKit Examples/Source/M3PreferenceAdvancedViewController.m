/*****************************************************************
 M3PreferenceAdvancedViewController.m
 M3AppKit
 
 Created by Martin Pilkington on 13/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3PreferenceAdvancedViewController.h"

@implementation M3PreferenceAdvancedViewController

- (id)init {
	if ((self = [super initWithNibName:@"M3PreferenceAdvancedView" bundle:nil])) {
		
	}
	return self;
}

- (NSImage *)image {
	return [NSImage imageNamed:NSImageNameAdvanced];
}

- (NSString *)title {
	return @"Advanced";
}

@end
