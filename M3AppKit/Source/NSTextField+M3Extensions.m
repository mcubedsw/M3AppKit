/*****************************************************************
 NSTextField+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 01/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSTextField+M3Extensions.h"


@implementation NSTextField (M3Extensions)


- (BOOL)m3_isLabel {
	return !self.isSelectable && !self.drawsBackground && !self.isBordered;
}


- (void)setM3_label:(BOOL)aIsLabel {
	[self setSelectable:!aIsLabel];
	[self setDrawsBackground:!aIsLabel];
	[self setBordered:!aIsLabel];
}

@end
