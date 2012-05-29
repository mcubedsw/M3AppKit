/*****************************************************************
 NSBezierPath+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 20/06/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 @category CLASS_HERE(CATEGORY_HERE)
 DISCUSSION_HERE
 @since Available in M3AppKit 1.0 and later
 */
@interface NSBezierPath (M3Extensions) 

/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since Available in M3AppKit 1.0 and later
 */
- (BOOL)m3_containsRect:(NSRect)rect;


+ (void)m3_strokeEdge:(NSRectEdge)aEdge ofRect:(NSRect)aRect;

@end
