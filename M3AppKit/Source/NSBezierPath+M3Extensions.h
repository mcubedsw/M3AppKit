/*****************************************************************
 NSBezierPath+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 20/06/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 A set of methods to help workign with NSBezierPaths
 @since M3AppKit 1.0 and later
 */
@interface NSBezierPath (M3Extensions) 

/**
 Checks if the supplied rect is fully contained in the receiver's path
 @param aRect The rectangle to check
 @result YES if the rect is contained by the path, no if it isn't.
 @since M3AppKit 1.0 and later
 */
- (BOOL)m3_containsRect:(NSRect)aRect;

/**
 Convenience method of stroking a particular edge of a rectangle
 @param aEdge The edge of the rectangle to be stroked
 @param aRect The rectangle to stroke
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (void)m3_strokeEdge:(NSRectEdge)aEdge ofRect:(NSRect)aRect;

@end
