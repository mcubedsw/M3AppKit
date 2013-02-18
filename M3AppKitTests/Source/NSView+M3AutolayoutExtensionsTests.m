/*****************************************************************
 NSView+M3AutolayoutExtensionsTests.m
 M3AppKit
 
 Created by Martin Pilkington on 12/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSView+M3AutolayoutExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSView_M3AutolayoutExtensionsTests

- (void)test_addingSubviewAddsItToView {
	NSView *superview = [NSView new];
	NSView *subview = [NSView new];
	[superview m3_addSubview:subview marginsToSuperview:NSEdgeInsetsMake(0, 0, 0, 0)];
	assertThat(superview.subviews, hasItem(subview));
}

@end
