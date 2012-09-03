/*****************************************************************
 NSView+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 24/07/2009.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSView+M3Extensions.h"


@implementation NSView(M3Extensions)

//*****//
- (BOOL)m3_containsView:(NSView *)view {
	if (view == self) {
		return YES;
	}
	for (NSView *subview in self.subviews) {
		if ([subview m3_containsView:view]) {
			return YES;
		}
	}
	return NO;
}

//*****//
- (NSString *)m3_viewName {
	NSString *value = @"";
	if ([self respondsToSelector:@selector(stringValue)]) {
		value = [NSString stringWithFormat:@"(%@)", [self performSelector:@selector(stringValue)]];
	}
	if ([self respondsToSelector:@selector(title)]) {
		value = [NSString stringWithFormat:@"(%@)", [self performSelector:@selector(title)]];
	}
	
	return [NSString stringWithFormat:@"%@ %@", self.className, value];
}

//*****//
- (void)m3_removeAllSubviews {
	NSArray *subviews = [self.subviews copy];
	for (NSView *subview in subviews) {
		[subview removeFromSuperview];
	}
}

//*****//
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

//*****//
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

//*****//
NSComparisonResult m3_blockSubviewSort(id obj1, id obj2, void *aBlock);
NSComparisonResult m3_blockSubviewSort(id obj1, id obj2, void *aBlock) {
	NSComparator comparisonBlock = (__bridge NSComparator)aBlock;
	return comparisonBlock(obj1, obj2);
}

//*****//
- (void)m3_sortSubviewsUsingBlock:(NSComparator)aComparator {
	NSComparator heapBlock = [aComparator copy];
	[self sortSubviewsUsingFunction:&m3_blockSubviewSort context:(__bridge void *)(heapBlock)];
}


//*****//
- (void)m3_addSubview:(NSView *)aSubview andFillConstraintsWithInset:(NSEdgeInsets)aInsets {
	[self m3_addSubview:aSubview andFillConstraintsWithInset:aInsets animated:NO];
}

//*****//
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

- (void)m3_addConstraints:(NSArray *)aConstraints forViews:(id)aViews substitutionViews:(id)aSubstitutionViews {
	
}

@end
