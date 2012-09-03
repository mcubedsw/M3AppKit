//
//  NSImage+M3Extensions.h
//  M3AppKit
//
//  Created by Martin Pilkington on 03/07/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (M3Extensions)

+ (NSImage *)m3_imageWithSize:(NSSize)aSize content:(void (^)(void))aDrawingBlock;

@end
