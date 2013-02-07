//
//  NSView+M3AutolayoutExtensions.m
//  M3AppKit
//
//  Created by Martin Pilkington on 01/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "NSView+M3AutolayoutExtensions.h"

#import "M3ConstraintStringParser.h"

@implementation NSView (M3AutolayoutExtensions)

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


- (void)m3_addConstraintsFromStrings:(NSArray *)aConstraints forViews:(id)aSubstitutionViews {
	M3ConstraintStringParser *parser = [[M3ConstraintStringParser alloc] initWithSubstitutionViews:[M3ConstraintStringParser substitutionViewsWithCollection:aSubstitutionViews selfView:self]];
	for (NSString *constraint in aConstraints) {
		[self addConstraints:[parser constraintsFromString:constraint]];
	}
}

@end
