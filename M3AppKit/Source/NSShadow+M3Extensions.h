/*****************************************************************
 NSShadow+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 15/12/2009.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 DISCUSSION_HERE
 */
@interface NSShadow (M3Extensions) 

/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since M3AppKit 1.0 and later
 */
+ (NSShadow *)m3_shadowWithColor:(NSColor *)color offset:(NSSize)offset blurRadius:(CGFloat)blur;

@end
