//
//  M3PreferenceAdvancedViewController.m
//  M3AppKit Examples
//
//  Created by Martin Pilkington on 13/02/2013.
//  Copyright (c) 2013 M Cubed Software Ltd. All rights reserved.
//

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
