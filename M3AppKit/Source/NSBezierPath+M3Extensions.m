/*****************************************************************
 NSBezierPath+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 20/06/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSBezierPath+M3Extensions.h"


@implementation NSBezierPath (M3Extensions)

- (BOOL)m3_containsRect:(NSRect)rect {
	//bottom left
	if (![self containsPoint:NSMakePoint(NSMinX(rect), NSMinY(rect))]) {
		return NO;
	}

	if (![self containsPoint:NSMakePoint(NSMaxX(rect), NSMinY(rect))]) {
		return NO;
	}

	if (![self containsPoint:NSMakePoint(NSMinX(rect), NSMaxY(rect))]) {
		return NO;
	}

	if (![self containsPoint:NSMakePoint(NSMaxX(rect), NSMaxY(rect))]) {
		return NO;
	}
	return YES;
}


+ (void)m3_strokeEdge:(NSRectEdge)aEdge ofRect:(NSRect)aRect {
	CGFloat x1 = 0;
	CGFloat x2 = 0;
	CGFloat y1 = 0;
	CGFloat y2 = 0;
	
	if (aEdge == NSMinXEdge) {
		x1 = x2 = NSMinX(aRect);
		y1 = NSMinY(aRect);
		y2 = NSMaxY(aRect);
	} else if (aEdge == NSMaxXEdge) {
		x1 = x2 = NSMaxX(aRect);
		y1 = NSMinY(aRect);
		y2 = NSMaxY(aRect);
	} else if (aEdge == NSMinYEdge) {
		y1 = y2 = NSMinY(aRect);
		x1 = NSMinX(aRect);
		x2 = NSMaxX(aRect);
	} else if (aEdge == NSMaxYEdge) {
		y1 = y2 = NSMaxY(aRect);
		x1 = NSMinX(aRect);
		x2 = NSMaxX(aRect);
	}
	
	[NSBezierPath strokeLineFromPoint:NSMakePoint(x1, y1) toPoint:NSMakePoint(x2, y2)];
}

@end
