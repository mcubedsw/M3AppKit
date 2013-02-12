/*****************************************************************
 NSView+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 24/07/2009.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSView+M3Extensions.h"
#import "M3ConstraintStringParser.h"

@implementation NSView(M3Extensions)


- (BOOL)m3_containsView:(NSView *)view {
	if (view == self) {
		return NO;
	}
	for (NSView *subview in self.subviews) {
		if ([subview isEqual:view]) return YES;
		if ([subview m3_containsView:view]) {
			return YES;
		}
	}
	return NO;
}


- (NSString *)m3_viewName {
	NSString *value = @"";
	if ([self respondsToSelector:@selector(stringValue)]) {
		value = [NSString stringWithFormat:@" (%@)", [self performSelector:@selector(stringValue)]];
	}
	if ([self respondsToSelector:@selector(title)]) {
		value = [NSString stringWithFormat:@" (%@)", [self performSelector:@selector(title)]];
	}
	
	return [NSString stringWithFormat:@"%@%@", self.className, value];
}


- (void)m3_removeAllSubviews {
	NSArray *subviews = [self.subviews copy];
	for (NSView *subview in subviews) {
		[subview removeFromSuperview];
	}
}


- (void)m3_bringViewToFront {
	[self.superview m3_sortSubviewsUsingBlock:^NSComparisonResult(id obj1, id obj2) {
		if (obj1 == self) {
			return NSOrderedDescending;
		}
		if (obj2 == self) {
			return NSOrderedAscending;
		}
		return NSOrderedSame;
	}];
}


- (void)m3_sendViewToBack {
	[self.superview m3_sortSubviewsUsingBlock:^NSComparisonResult(id obj1, id obj2) {
		if (obj1 == self) {
			return NSOrderedAscending;
		}
		if (obj2 == self) {
			return NSOrderedDescending;
		}
		return NSOrderedSame;
	}];
}


NSComparisonResult m3_blockSubviewSort(id obj1, id obj2, void *aBlock);
NSComparisonResult m3_blockSubviewSort(id obj1, id obj2, void *aBlock) {
	NSComparator comparisonBlock = (__bridge NSComparator)aBlock;
	return comparisonBlock(obj1, obj2);
}


- (void)m3_sortSubviewsUsingBlock:(NSComparator)aComparator {
	NSComparator heapBlock = [aComparator copy];
	[self sortSubviewsUsingFunction:&m3_blockSubviewSort context:(__bridge void *)(heapBlock)];
}

@end
