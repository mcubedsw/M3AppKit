/*****************************************************************
 NSView+M3Extensions.m
 M3Extensions
 
 Created by Martin Pilkington on 24/07/2009.
 
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

#import "NSView+M3Extensions.h"


@implementation NSView(M3Extensions)

- (BOOL)m3_containsView:(NSView *)view {
	if (view == self) {
		return YES;
	}
	for (NSView *subview in [self subviews]) {
		if ([subview m3_containsView:view]) {
			return YES;
		}
	}
	return NO;
}

- (NSString *)m3_viewName {
	NSString *value = @"";
	if ([self respondsToSelector:@selector(stringValue)])
		value = [NSString stringWithFormat:@"(%@)", [self performSelector:@selector(stringValue)]];
	if ([self respondsToSelector:@selector(title)])
		value = [NSString stringWithFormat:@"(%@)", [self performSelector:@selector(title)]];
	
	return [NSString stringWithFormat:@"%@ %@", [self className], value];
}

- (void)removeAllSubviews {
	NSArray *subviews = [[self subviews] copy];
	for (NSView *subview in subviews) {
		[subview removeFromSuperview];
	}
	[subviews release];
}

- (void)m3_bringViewToFront {
	[[self superview] m3_sortSubviewsUsingBlock:^NSComparisonResult(id obj1, id obj2) {
		if (obj1 == self)
			return NSOrderedDescending;
		if (obj2 == self)
			return NSOrderedAscending;
		return NSOrderedSame;
	}];
}

- (void)m3_sendViewToBack {
	[[self superview] m3_sortSubviewsUsingBlock:^NSComparisonResult(id obj1, id obj2) {
		if (obj1 == self)
			return NSOrderedAscending;
		if (obj2 == self)
			return NSOrderedDescending;
		return NSOrderedSame;
	}];
}

NSComparisonResult m3_blockSubviewSort(id obj1, id obj2, void *aBlock);
NSComparisonResult m3_blockSubviewSort(id obj1, id obj2, void *aBlock) {
	NSComparator comparisonBlock = (NSComparator)aBlock;
	return comparisonBlock(obj1, obj2);
}

- (void)m3_sortSubviewsUsingBlock:(NSComparator)aComparator {
	NSComparator heapBlock = [aComparator copy];
	[self sortSubviewsUsingFunction:&m3_blockSubviewSort context:heapBlock];
	[heapBlock release];
}


#if MAC_OS_X_VERSION_MAX_ALLOWED >= 1070

- (void)m3_addSubview:(NSView *)aSubview andFillConstraintsWithInset:(NSEdgeInsets)aInsets {
	[self m3_addSubview:aSubview andFillConstraintsWithInset:aInsets animated:NO];
}

- (void)m3_addSubview:(NSView *)aSubview andFillConstraintsWithInset:(NSEdgeInsets)aInsets animated:(BOOL)aAnimated {
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
		[context setDuration:aAnimated ? 5 : 0];
		
		[aSubview setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:aSubview];
		
		NSDictionary *subviewDict = NSDictionaryOfVariableBindings(aSubview);
		[[self animator] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(%f)-[aSubview]-(%f)-|", aInsets.left, aInsets.right] options:0 metrics:nil views:subviewDict]];
		[[self animator] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(%f)-[aSubview]-(%f)-|", aInsets.top, aInsets.bottom] options:0 metrics:nil views:subviewDict]];
	} completionHandler:nil];	
}

#endif

@end
