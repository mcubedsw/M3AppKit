/*****************************************************************
 NSBezierPath+M3Extensions
 M3Extensions
 
 Created by Martin Pilkington on 20/06/2010.
 
 Copyright (c) 2006-2010 M Cubed Software
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 *****************************************************************/

#import "NSBezierPath+M3Extensions.h"


@implementation NSBezierPath (M3Extensions)

- (BOOL)m3_containsRect:(NSRect)rect {
	//bottom left
	if (![self containsPoint:NSMakePoint(NSMinX(rect), NSMinY(rect))])
		return NO;
	if (![self containsPoint:NSMakePoint(NSMaxX(rect), NSMinY(rect))])
		return NO;
	if (![self containsPoint:NSMakePoint(NSMinX(rect), NSMaxY(rect))])
		return NO;
	if (![self containsPoint:NSMakePoint(NSMaxX(rect), NSMaxY(rect))])
		return NO;
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
