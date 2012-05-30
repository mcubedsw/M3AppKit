/*****************************************************************
 NSShadow+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 15/12/2009.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSShadow+M3Extensions.h"


@implementation NSShadow (M3Extensions)

+ (NSShadow *)shadowWithColor:(NSColor *)color offset:(NSSize)offset blurRadius:(CGFloat)blur {
	return [self m3_shadowWithColor:color offset:offset blurRadius:blur];
}

+ (NSShadow *)m3_shadowWithColor:(NSColor *)color offset:(NSSize)offset blurRadius:(CGFloat)blur {
	NSShadow *shadow = [[NSShadow alloc] init];
	[shadow setShadowColor:color];
	[shadow setShadowOffset:offset];
	[shadow setShadowBlurRadius:blur];
	
	return shadow;
}

@end
