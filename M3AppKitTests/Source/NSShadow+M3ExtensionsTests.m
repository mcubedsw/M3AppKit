//
//  NSShadow+M3Extensions.m
//  M3AppKit
//
//  Created by Martin Pilkington on 11/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "NSShadow+M3ExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSShadow_M3ExtensionsTests

- (void)test_createsNSShadowWithSuppliedValues {
	NSShadow *shadow = [NSShadow m3_shadowWithColor:[NSColor redColor] offset:NSMakeSize(5, 3) blurRadius:4];
	assertThat(shadow.shadowColor, is(equalTo([NSColor redColor])));
	assertThatFloat(shadow.shadowOffset.width, is(equalToFloat(5)));
	assertThatFloat(shadow.shadowOffset.height, is(equalToFloat(3)));
	assertThatFloat(shadow.shadowBlurRadius, is(equalToFloat(4)));
}

@end
