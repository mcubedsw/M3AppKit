//
//  NSView+M3AutolayoutExtensionsTests.m
//  M3AppKit
//
//  Created by Martin Pilkington on 12/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "NSView+M3AutolayoutExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSView_M3AutolayoutExtensionsTests

- (void)test_addingSubviewAddsItToView {
	NSView *superview = [NSView new];
	NSView *subview = [NSView new];
	[superview m3_addSubview:subview andFillConstraintsWithInset:NSEdgeInsetsMake(0, 0, 0, 0)];
	assertThat(superview.subviews, hasItem(subview));
}

@end
