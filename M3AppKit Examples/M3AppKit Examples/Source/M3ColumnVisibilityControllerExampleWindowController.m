//
//  M3ColumnVisibilityControllerExampleWindowController.m
//  M3AppKit Examples
//
//  Created by Martin Pilkington on 12/02/2013.
//  Copyright (c) 2013 M Cubed Software Ltd. All rights reserved.
//

#import "M3ColumnVisibilityControllerExampleWindowController.h"

@implementation M3ColumnVisibilityControllerExampleWindowController

- (id)init {
	if ((self = [super initWithWindowNibName:@"M3ColumnVisibilityControllerExampleWindow"])) {
		
	}
	return self;
}

- (IBAction)updateIgnored:(NSSegmentedControl *)sender {
	NSMutableArray *ignoredColumns = [NSMutableArray array];
	for (NSUInteger segment = 0; segment < sender.segmentCount; segment++) {
		if ([sender isSelectedForSegment:segment]) {
			[ignoredColumns addObject:[sender labelForSegment:segment]];
		}
	}
	[self.columnVisibilityController setIgnoredColumnIdentifiers:ignoredColumns];
}

@end
