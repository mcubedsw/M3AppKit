/*****************************************************************
 NSTextField+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 01/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSTextField+M3Extensions.h"


@implementation NSTextField (M3Extensions)

- (BOOL)isLabel {
	return [self isSelectable] && [self drawsBackground] && [self isBordered];
}

- (void)setLabel:(BOOL)aIsLabel {
	[self setSelectable:NO];
	[self setDrawsBackground:NO];
	[self setBordered:NO];
}

@end
