//
//  NSTextField+M3Extensions.m
//  M3AppKit
//
//  Created by Martin Pilkington on 01/08/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

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
