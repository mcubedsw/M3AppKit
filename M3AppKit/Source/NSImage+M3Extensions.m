//
//  NSImage+M3Extensions.m
//  M3AppKit
//
//  Created by Martin Pilkington on 03/07/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "NSImage+M3Extensions.h"

@implementation NSImage (M3Extensions)

+ (NSImage *)m3_imageWithSize:(NSSize)aSize content:(void (^)(void))aDrawingBlock {
	NSImage *image = [[NSImage alloc] initWithSize:aSize];
	[image lockFocus];
	aDrawingBlock();
	[image unlockFocus];
	return image;
}

@end
